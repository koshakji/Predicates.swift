//
//  StringPredicates.swift
//  
//
//  Created by Majd Koshakji on 4/1/23.
//

import Foundation
import Predicates

extension StringContains: NSPredicateConvertible where Root: Keyable {
    public var nsPredicate: NSPredicate {
        return NSPredicate(format: "\(key()) CONTAINS %@", argumentArray: [self.value])
    }
}

extension HasPrefix: NSPredicateConvertible where Root: Keyable {
    public var nsPredicate: NSPredicate {
        return NSPredicate(format: "\(key()) BEGINSWITH %@", argumentArray: [self.value])
    }
}

extension HasSuffix: NSPredicateConvertible where Root: Keyable {
    public var nsPredicate: NSPredicate {
        return NSPredicate(format: "\(key()) ENDSWITH %@", argumentArray: [self.value])
    }
}

@available(macOS 13.0, *)
@available(iOS 16, *)
extension MatchesRegex: NSPredicateConvertible where Root: Keyable {
    public var nsPredicate: NSPredicate {
        return NSPredicate(format: "\(key()) MATCHES %@", argumentArray: [self.value])
    }
}
