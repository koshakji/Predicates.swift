//
//  BooleanPredicates.swift
//  Predicates
//
//  Created by Majd Koshakji on 1/11/22.
//

public struct BoolPredicate<Root>: ValuePredicate, ExpressibleByBooleanLiteral {
    public let value: Bool
    
    public init(value: Bool) {
        self.value = value
    }
    
    public init(booleanLiteral value: Bool) {
        self.init(value: value)
    }
    
    public func evaluate(_ instance: Root) -> Bool {
        return value
    }
}

public struct BoolKeyPathPredicate<Root>: Predicate{
    public let keyPath: KeyPath<Root, Bool>
    
    public func evaluate(_ instance: Root) -> Bool {
        return instance[keyPath: keyPath]
    }
}


public extension Predicate {
    static func &&(_ lhs: Self, rhs: Bool) -> And<Root, Self, BoolPredicate<Root>> {
        return And(lhs: lhs, rhs: BoolPredicate(value: rhs))
    }
    
    static func &&(_ lhs: Bool, rhs: Self) -> And<Root, BoolPredicate<Root>, Self> {
        return And(lhs: BoolPredicate(value: lhs), rhs: rhs)
    }

    static func ||(_ lhs: Self, rhs: Bool) -> Or<Root, Self, BoolPredicate<Root>> {
        return Or(lhs: lhs, rhs: BoolPredicate(value: rhs))
    }

    static func ||(_ lhs: Bool, rhs: Self) -> Or<Root, BoolPredicate<Root>, Self> {
        return Or(lhs: BoolPredicate(value: lhs), rhs: rhs)
    }
    
    static func &&(_ lhs: Self, rhs: KeyPath<Root, Bool>) -> And<Root, Self, BoolKeyPathPredicate<Root>> {
        return And(lhs: lhs, rhs: BoolKeyPathPredicate(keyPath: rhs))
    }
    
    static func &&(_ lhs: KeyPath<Root, Bool>, rhs: Self) -> And<Root, BoolKeyPathPredicate<Root>, Self> {
        return And(lhs: BoolKeyPathPredicate(keyPath: lhs), rhs: rhs)
    }
    
    static func ||(_ lhs: Self, rhs: KeyPath<Root, Bool>) -> Or<Root, Self, BoolKeyPathPredicate<Root>> {
        return Or(lhs: lhs, rhs: BoolKeyPathPredicate(keyPath: rhs))
    }
    
    static func ||(_ lhs: KeyPath<Root, Bool>, rhs: Self) -> Or<Root, BoolKeyPathPredicate<Root>, Self> {
        return Or(lhs: BoolKeyPathPredicate(keyPath: lhs), rhs: rhs)
    }
}

extension KeyPath where Value == Bool {
    static prefix func !(_ keyPath: KeyPath<Root, Bool>) -> Not<Root, BoolKeyPathPredicate<Root>> {
        return Not(basePredicate: BoolKeyPathPredicate(keyPath: keyPath))
    }
}
