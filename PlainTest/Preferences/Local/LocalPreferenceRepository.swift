//
//  LocalPreferenceRepository.swift
//  Popai
//
//  Created by Philipp Gewinner on 04.08.20.
//  Copyright © 2020 Alysis. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift
import UIKit

class LocalPreferenceRepository: PreferenceRepository {
    let userDefaults = UserDefaults.standard

    // preference keys
    private static let PREF_FIRST_LAUNCH = "prefFirstLaunch"

    private let prefs = UserDefaults.standard

    init() {
        LocalPreferenceRepository.registerDefaults()
    }
    // preference default values
    class func registerDefaults() {
        let defaults: [String: Any] = [
            LocalPreferenceRepository.PREF_FIRST_LAUNCH: true
        ]

        UserDefaults.standard.register(defaults: defaults)
    }

    func setFirstLaunch(value: Bool) {
        userDefaults.set(value, forKey: LocalPreferenceRepository.PREF_FIRST_LAUNCH)
    }

    func isFirstLaunch() -> Bool {
        return userDefaults.bool(forKey: LocalPreferenceRepository.PREF_FIRST_LAUNCH)
    }

}
