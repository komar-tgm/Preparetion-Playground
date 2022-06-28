//
//  DatabaseViewController.swift
//  PlainTest
//
//  Created by Karim Omar on 23.06.22.
//

import Foundation
import UIKit
import RealmSwift

class DatabaseViewController: UIViewController {
    private var databaseViewModel = DatabaseViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        databaseViewModel.testInsert(number: Number(value: 100))
        print("Launch Info: \(self.databaseViewModel.getLaunchInfo())")
        self.databaseViewModel.setFirstLaunch(value: false)
    }
}
