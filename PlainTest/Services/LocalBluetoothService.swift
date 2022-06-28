//
//  BluetoothService.swift
//  PlainTest
//
//  Created by Karim Omar on 27.06.22.
//

import Foundation
import CoreBluetooth
import UIKit

class LocalBluetoothService: NSObject, BluetoothService, CBCentralManagerDelegate, CBPeripheralDelegate {

    var centralManager: CBCentralManager?
    var peripheral: CBPeripheral?
    var array = [CBPeripheral]()

    required override init() {
        super.init()
        print("INIT SERVICE")
    }

    func initCentralManager() {
        self.centralManager = CBCentralManager.init(delegate: self, queue: nil)
        
    }

    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        guard central.state == .poweredOn else {
                print("No Bluetooth available")
            return
            }
        print("BLUETOOTH ON")
            central.scanForPeripherals(withServices: nil, options: nil)
    }

    func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String : Any], rssi RSSI: NSNumber) {
        if peripheral.name == "Train.Red FYER 0047" {
            print("Found peripheral: \(peripheral.description)")
            peripheral.delegate = self
            self.array.append(peripheral)
            self.centralManager?.connect(peripheral, options: nil)
            self.peripheral = peripheral
        } else {
            // print("Found ELSE: \(peripheral.description)")
        }
    }
    
    func centralManager(_ central: CBCentralManager, didConnect peripheral: CBPeripheral) {
        print("Connected to peripheral: \(peripheral.description)")
        peripheral.discoverServices(nil)
    }

    func centralManager(_ central: CBCentralManager, didDisconnectPeripheral peripheral: CBPeripheral, error: Error?) {
        print("Disconnected : \(peripheral.name ?? "No Name")")
        self.centralManager?.scanForPeripherals(withServices: nil, options: nil)
    }
    
    func peripheral(_ peripheral: CBPeripheral, didDiscoverServices error: Error?) {
        peripheral.services?.forEach { service in
            print("Discovered service: \(service.description)")
            if service.uuid == CBUUID(string: "00002200-D578-4741-9B5B-7C64E958CFC6") {
                peripheral.discoverCharacteristics(nil, for: service)
            }
        }
    }

    func peripheral(_ peripheral: CBPeripheral, didDiscoverCharacteristicsFor service: CBService, error: Error?) {
        service.characteristics?.forEach { characteristic in
            print("Discovered characteristic: \(characteristic.description) for service \(service.uuid)")
            if (characteristic.uuid == CBUUID(string: "00002201-D578-4741-9B5B-7C64E958CFC6")) {
                peripheral.setNotifyValue(true, for: characteristic)
            }
          }
    }

    func peripheral(_ peripheral: CBPeripheral, didUpdateValueFor characteristic: CBCharacteristic, error: Error?) {
        guard characteristic.service?.uuid == CBUUID(string: "00002200-D578-4741-9B5B-7C64E958CFC6"),
                  characteristic.uuid == CBUUID(string: "00002201-D578-4741-9B5B-7C64E958CFC6"),
                  let data = characteristic.value else {
                return
        }

        let numberOfBytes = data.count
        var byteArray = [UInt8](repeating: 0, count: numberOfBytes)
        (data as NSData).getBytes(&byteArray, length: numberOfBytes)

        print("Data: \(byteArray)")
    }
    
    func cleanClose() {
        self.array.forEach { peripheral in
            self.centralManager?.cancelPeripheralConnection(peripheral)
        }
        self.centralManager = nil
    }
}
