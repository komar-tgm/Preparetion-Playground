//
//  PreferenceRepository.swift
//  Popai
//
//  Created by Philipp Gewinner on 04.08.20.
//  Copyright © 2020 Alysis. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

protocol PreferenceRepository: AnyObject {

    func setFirstLaunch(value: Bool)
    func isFirstLaunch() -> Bool
}
