//
//  LocalDataRepository.swift
//  PlainTest
//
//  Created by Karim Omar on 24.06.22.
//

import Foundation
import RealmSwift

class LocalDataRepository: DataRepository {

    // implements stubs and access the concrete object daos for each entity which is used

    let realmDB: Realm
    let numberDao: NumberDao

    init(realmDB: Realm) {
        self.realmDB = realmDB
        self.numberDao = NumberDao(realmDB: realmDB)
    }

    func insertNumber(number: Number) {
        self.numberDao.insert(number: number)
    }
    
    func getAllNumbers() -> Results<Number>{
        return self.numberDao.getAllNumbers()
    }

    func deleteAllNumbers() {
        self.numberDao.deleteAllNumbers()
    }
    
    func getNumberFromValue(value: Int) -> Results<Number> {
        return self.numberDao.getNumberFromValue(value: value)
    }
    

}
