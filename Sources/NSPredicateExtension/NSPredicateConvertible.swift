//
//  NSPredicateConvertible.swift
//  Predicates
//
//  Created by Majd Koshakji on 14/11/22.
//

import Foundation
import Predicates

public protocol NSPredicateConvertible: Predicate where Root: Keyable {
    var nsPredicate: NSPredicate { get }
}
