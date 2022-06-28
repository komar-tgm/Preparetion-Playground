//
//  BluetoothService.swift
//  PlainTest
//
//  Created by Karim Omar on 27.06.22.
//

import Foundation
import CoreBluetooth

extension ViewController: CBCentralManagerDelegate {
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        
    }
}

extension ViewController: CBPeripheralDelegate {
    
}
