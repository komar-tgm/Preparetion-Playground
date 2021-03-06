//
//  Injection.swift
//  PlainTest
//
//  Created by Karim Omar on 24.06.22.
//

import Foundation
import Resolver

extension Resolver: ResolverRegistering {

    private static var dataRepo = LocalDataRepository(realmDB: AppDatabase.getDatabase())
    private static var prefRepo = LocalPreferenceRepository()
    private static var bluetoothService = LocalBluetoothService()

    public static func registerAllServices() {
        register { self.dataRepo }.implements(DataRepository.self)
        register { self.prefRepo }.implements(PreferenceRepository.self)
        register { self.bluetoothService }.implements(BluetoothService.self)

    }
}
