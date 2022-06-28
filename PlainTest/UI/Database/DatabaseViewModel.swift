//
//  DatabaseViewModel.swift
//  PlainTest
//
//  Created by Karim Omar on 24.06.22.
//

import Foundation
import RxCocoa
import RxSwift
import Resolver
import RealmSwift

class DatabaseViewModel {
    @Injected var dataRepo: DataRepository
    @Injected var prefRepo: PreferenceRepository
    
    func testInsert(number: Number) {
        self.dataRepo.insertNumber(number: number)
    }

    func getAllNumbers() -> Results<Number> {
        return self.dataRepo.getAllNumbers()
    }

    func deleteAllNumbers() {
        self.dataRepo.deleteAllNumbers()
    }

    func getNumberFromValue(value: Int) -> Results<Number> {
        return self.dataRepo.getNumberFromValue(value: value)
    }

    func setFirstLaunch(value: Bool) {
        self.prefRepo.setFirstLaunch(value: value)
    }

    func getLaunchInfo() -> Bool {
        return self.prefRepo.isFirstLaunch()
    }
}
