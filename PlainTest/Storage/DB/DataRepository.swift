//
//  DataRepository.swift
//  PlainTest
//
//  Created by Karim Omar on 24.06.22.
//

import Foundation
import RealmSwift

// defines method stubs for database actions
protocol DataRepository: AnyObject {

    func insertNumber(number: Number)

    func getAllNumbers() -> Results<Number>
    
    func deleteAllNumbers()
    
    func getNumberFromValue(value: Int) -> Results<Number>
}
