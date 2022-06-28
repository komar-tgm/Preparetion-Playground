//
//  AppDatabase.swift
//  PlainTest
//
//  Created by Karim Omar on 24.06.22.
//

import Foundation
import RealmSwift

struct AppDatabase {
    static var realm: Realm {
        get {
            do {
                Realm.Configuration.defaultConfiguration = Realm.Configuration(
                    schemaVersion: 1,
                    migrationBlock: { migration, oldSchemaVersion in
                        if (oldSchemaVersion < 1) {

                            // enumerate first object

                            migration.enumerateObjects(ofType: Number.className()) { oldItem, newItem in
                                let number = Number()
                                number._id = oldItem?["_id"] as! ObjectId
                                number.value = oldItem?["value"] as! Int
                                newItem?["timestamp"] = number
                            }
                            
                        }
                })

                let realm = try Realm()
                return realm
            }
            catch {
                print("Could not access database: \(error)")
            }
            return self.realm
        }
    }

    static func getDatabase() -> Realm {
        return self.realm
    }
}
