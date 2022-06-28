//
//  Number.swift
//  PlainTest
//
//  Created by Karim Omar on 24.06.22.
//

import Foundation
import RealmSwift

class Number: Object {
    @Persisted(primaryKey: true) var _id: ObjectId
    @Persisted var value: Int = 0
    @Persisted var timestamp: Date = Date()
    
    convenience init(value: Int) {
        self.init()
        self.value = value
    }
}
