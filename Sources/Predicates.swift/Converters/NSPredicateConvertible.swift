//
//  NSPredicateConvertible.swift
//  Predicates
//
//  Created by Majd Koshakji on 14/11/22.
//

import Foundation

protocol NSPredicateConvertible: Predicate where Root: Keyable {
    func nsPredicate() -> NSPredicate
}


//MARK: - Element Predicates
extension Equals: NSPredicateConvertible where Root: Keyable {
    func nsPredicate() -> NSPredicate {
        return NSPredicate(format: "\(key()) = %@", argumentArray: [self.value])
    }
}

extension GreaterThan: NSPredicateConvertible where Root: Keyable {
    func nsPredicate() -> NSPredicate {
        return NSPredicate(format: "\(key()) > %@", argumentArray: [self.value])
    }
}

extension LessThan: NSPredicateConvertible where Root: Keyable {
    func nsPredicate() -> NSPredicate {
        return NSPredicate(format: "\(key()) < %@", argumentArray: [self.value])
    }
}

extension GreaterThanOrEqual: NSPredicateConvertible where Root: Keyable {
    func nsPredicate() -> NSPredicate {
        return NSPredicate(format: "\(key()) >= %@", argumentArray: [self.value])
    }
}

extension LessThanOrEqual: NSPredicateConvertible where Root: Keyable {
    func nsPredicate() -> NSPredicate {
        return NSPredicate(format: "\(key()) <= %@", argumentArray: [self.value])
    }
}

//MARK: - Bool Predicates
extension BoolPredicate: NSPredicateConvertible where Root: Keyable {
    func nsPredicate() -> NSPredicate {
        return NSPredicate(value: self.value)
    }
}

//MARK: - Collection Predicates
extension Contains: NSPredicateConvertible where Root: Keyable {
    func nsPredicate() -> NSPredicate {
        return NSPredicate(format: "%@ IN \(key())", argumentArray: [self.value])
    }
}

extension ContainsSet: NSPredicateConvertible where Root: Keyable {
    func nsPredicate() -> NSPredicate {
        return NSPredicate(format: "%@ IN \(key())", argumentArray: [self.value])
    }
}

//MARK: - Operators
extension Not: NSPredicateConvertible where Root: Keyable, Base: NSPredicateConvertible {
    func nsPredicate() -> NSPredicate {
        return NSCompoundPredicate(notPredicateWithSubpredicate: self.basePredicate.nsPredicate())
    }
}

extension And: NSPredicateConvertible where LHS: NSPredicateConvertible, RHS: NSPredicateConvertible {
    func nsPredicate() -> NSPredicate {
        return NSCompoundPredicate(
            type: .and,
            subpredicates: [
                lhs.nsPredicate(),
                rhs.nsPredicate()
            ])
    }
}

extension Or: NSPredicateConvertible where LHS: NSPredicateConvertible, RHS: NSPredicateConvertible {
    func nsPredicate() -> NSPredicate {
        return NSCompoundPredicate(
            type: .or,
            subpredicates: [
                lhs.nsPredicate(),
                rhs.nsPredicate()
            ])
    }
}

//MARK: - String Predicates
extension StringContains: NSPredicateConvertible where Root: Keyable {
    func nsPredicate() -> NSPredicate {
        return NSPredicate(format: "\(key()) CONTAINS %@", argumentArray: [self.value])
    }
}

extension HasPrefix: NSPredicateConvertible where Root: Keyable {
    func nsPredicate() -> NSPredicate {
        return NSPredicate(format: "\(key()) BEGINSWITH %@", argumentArray: [self.value])
    }
}

extension HasSuffix: NSPredicateConvertible where Root: Keyable {
    func nsPredicate() -> NSPredicate {
        return NSPredicate(format: "\(key()) ENDSWITH %@", argumentArray: [self.value])
    }
}

//extension MatchesRegex: NSPredicateConvertible where Root: Keyable {
//    func nsPredicate() -> NSPredicate {
//        return NSPredicate(format: "\(key()) MATCHES %@", argumentArray: [self.value])
//    }
//}
