//
//  ElementPredicates.swift
//  
//
//  Created by Majd Koshakji on 4/1/23.
//

import Foundation
import Predicates

extension Equals: NSPredicateConvertible where Root: Keyable {
    public var nsPredicate: NSPredicate {
        return NSPredicate(format: "\(key()) = %@", argumentArray: [self.value])
    }
}

extension GreaterThan: NSPredicateConvertible where Root: Keyable {
    public var nsPredicate: NSPredicate {
        return NSPredicate(format: "\(key()) > %@", argumentArray: [self.value])
    }
}

extension LessThan: NSPredicateConvertible where Root: Keyable {
    public var nsPredicate: NSPredicate {
        return NSPredicate(format: "\(key()) < %@", argumentArray: [self.value])
    }
}

extension GreaterThanOrEqual: NSPredicateConvertible where Root: Keyable {
    public var nsPredicate: NSPredicate {
        return NSPredicate(format: "\(key()) >= %@", argumentArray: [self.value])
    }
}

extension LessThanOrEqual: NSPredicateConvertible where Root: Keyable {
    public var nsPredicate: NSPredicate {
        return NSPredicate(format: "\(key()) <= %@", argumentArray: [self.value])
    }
}
