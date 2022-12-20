//
//  Operators.swift
//  Predicates
//
//  Created by Majd Koshakji on 1/11/22.
//

public struct Not<Root, Base>: UnaryPredicateOperator where Base: Predicate, Base.Root == Root {
    public let basePredicate: Base

    public func evaluate(instance: Root) -> Bool {
        return !self.basePredicate.evaluate(instance: instance)
    }
}


public struct And<Root, LHS, RHS>: BinaryPredicateOperator where LHS: Predicate<Root>, RHS: Predicate<Root> {
    public let lhs: LHS
    public let rhs: RHS

    public func evaluate(instance: Root) -> Bool {
        return self.lhs.evaluate(instance: instance) && self.rhs.evaluate(instance: instance)
    }
}

public struct Or<Root, LHS, RHS>: BinaryPredicateOperator where LHS: Predicate<Root>, RHS: Predicate<Root> {
    public let lhs: LHS
    public let rhs: RHS

    public func evaluate(instance: Root) -> Bool {
        return self.lhs.evaluate(instance: instance) || self.rhs.evaluate(instance: instance)
    }
}

public extension Predicate {
    static func &&<RHS: Predicate<Root>>(_ lhs: Self, rhs: RHS) -> And<Root, Self, RHS> {
        return And(lhs: lhs, rhs: rhs)
    }

    static func ||<RHS: Predicate<Root>>(_ lhs: Self, rhs: RHS) -> Or<Root, Self, RHS> {
        return Or(lhs: lhs, rhs: rhs)
    }
    
    static prefix func !(_ comparison: Self) -> Not<Root, Self> {
        return Not(basePredicate: comparison)
    }
}
