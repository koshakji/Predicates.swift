//
//  BooleanPredicates.swift
//  
//
//  Created by Majd Koshakji on 4/1/23.
//

import Foundation
import Predicates

extension BoolPredicate: NSPredicateConvertible where Root: Keyable {
    public var nsPredicate: NSPredicate {
        return NSPredicate(value: self.value)
    }
}
