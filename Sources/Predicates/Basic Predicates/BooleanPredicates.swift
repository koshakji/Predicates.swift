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
    
    public func evaluate(instance: Root) -> Bool {
        return value
    }
}


public extension Predicate {
    static func &&(_ lhs: Self, rhs: Bool) -> And<Root, Self, BoolPredicate<Self.Root>> {
        return And(lhs: lhs, rhs: BoolPredicate(value: rhs))
    }
    
    static func &&(_ lhs: Bool, rhs: Self) -> And<Root, BoolPredicate<Self.Root>, Self> {
        return And(lhs: BoolPredicate(value: lhs), rhs: rhs)
    }

    static func ||(_ lhs: Self, rhs: Bool) -> Or<Root, Self, BoolPredicate<Self.Root>> {
        return Or(lhs: lhs, rhs: BoolPredicate(value: rhs))
    }

    static func ||(_ lhs: Bool, rhs: Self) -> Or<Root, BoolPredicate<Self.Root>, Self> {
        return Or(lhs: BoolPredicate(value: lhs), rhs: rhs)
    }
}
