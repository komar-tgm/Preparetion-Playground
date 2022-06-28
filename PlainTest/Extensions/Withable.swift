//
//  Withable.swift
//  AMSJobApp
//
//  Created by Karim Omar on 04.11.21.
//

import Foundation
import UIKit

/**
 * Extension to use Declarative UI-Elements
 */
protocol Withable {

    associatedtype T

    @discardableResult func with(_ closure: (_ view: T) -> Void) -> T
}
extension Withable {

    @discardableResult func with(_ closure: (_ view: Self) -> Void) -> Self {
        closure(self)
        return self
    }
}
extension NSObject: Withable { }

extension Array where Element: UIView {

    func add(to stackView: UIStackView) {
        forEach { stackView.addArrangedSubview($0) }
    }
}
