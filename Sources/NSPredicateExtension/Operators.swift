//
//  Operators.swift
//  
//
//  Created by Majd Koshakji on 4/1/23.
//

import Foundation
import Predicates


extension Not: NSPredicateConvertible where Root: Keyable, Base: NSPredicateConvertible {
    public var nsPredicate: NSPredicate {
        return NSCompoundPredicate(notPredicateWithSubpredicate: self.basePredicate.nsPredicate)
    }
}

extension And: NSPredicateConvertible where LHS: NSPredicateConvertible, RHS: NSPredicateConvertible {
    public var nsPredicate: NSPredicate {
        return NSCompoundPredicate(
            type: .and,
            subpredicates: [
                lhs.nsPredicate,
                rhs.nsPredicate
            ])
    }
}

extension Or: NSPredicateConvertible where LHS: NSPredicateConvertible, RHS: NSPredicateConvertible {
    public var nsPredicate: NSPredicate {
        return NSCompoundPredicate(
            type: .or,
            subpredicates: [
                lhs.nsPredicate,
                rhs.nsPredicate
            ])
    }
}
