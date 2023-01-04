//
//  CollectionPredicates.swift
//  
//
//  Created by Majd Koshakji on 4/1/23.
//

import Foundation
import Predicates

extension Contains: NSPredicateConvertible where Root: Keyable {
    public var nsPredicate: NSPredicate {
        return NSPredicate(format: "%@ IN \(key())", argumentArray: [self.value])
    }
}

extension ContainsSet: NSPredicateConvertible where Root: Keyable {
    public var nsPredicate: NSPredicate {
        return NSPredicate(format: "%@ IN \(key())", argumentArray: [self.value])
    }
}

