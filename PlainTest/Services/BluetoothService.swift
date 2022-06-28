//
//  BluetoothService.swift
//  PlainTest
//
//  Created by Karim Omar on 28.06.22.
//

import Foundation
protocol BluetoothService: AnyObject {
    func initCentralManager()
    func cleanClose()
}
