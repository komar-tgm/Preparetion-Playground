//
//  NumberDao.swift
//  PlainTest
//
//  Created by Karim Omar on 24.06.22.
//

import Foundation
import RealmSwift

class NumberDao {
    // object dao which has every database operation needed for this object
    
    let realmDB: Realm!
    
    init(realmDB: Realm!) {
        self.realmDB = realmDB
    }

    func insert(number: Number) {
        print("Insert \(number.value)")
        // begin write transaction
        try! self.realmDB.write {
            // adds number to realm database
            self.realmDB.add(number)
        }
    }

    func getAllNumbers() -> Results<Number>{
        print("GET all numbers")
        // fetches all Number objects from realm db
        return realmDB.objects(Number.self).sorted(byKeyPath: "_id")
    }

    func deleteAllNumbers() {
        do {
            try self.realmDB.write {
                self.realmDB.delete(self.realmDB.objects(Number.self))
            }
        } catch(let error) {
            print(error)
        }
//        try! self.realmDB.write {
//            self.realmDB.delete(self.realmDB.objects(Number.self))
//        }
    }
    
    func getNumberFromValue(value: Int) -> Results<Number> {
        return self.realmDB.objects(Number.self).sorted(byKeyPath: "_id").where {
            $0.value == value
        }
    }
}
