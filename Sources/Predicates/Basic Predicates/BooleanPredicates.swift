//
//  BooleanPredicates.swift
//  Predicates
//
//  Created by Majd Koshakji on 1/11/22.
//

/// A predicate that always return a specific `Bool` value regardless of the instance object.
public struct BoolPredicate<Root>: ValuePredicate, ExpressibleByBooleanLiteral {
    
    /// The boolean value that will be returned
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
    
    /// Applies the ``And`` operator between a ``Predicate`` and a boolean
    /// - Parameters:
    ///   - lhs: Any predicate
    ///   - rhs: A boolean
    /// - Returns: An ``And`` predicate with the left-hand side being the `lhs` predicate, and the right-hand side being a ``BoolPredicate`` with the boolean value of the `rhs` parameter
    ///
    /// Example:
    /// ```swift
    /// let countPredicate = \Array<Int>.count == 3
    /// let and = countPredicate && false
    ///
    /// countPredicate.evaluate(instance: [1,2,3]) // true
    /// and.evaluate(instance: [1,2,3]) // (true && false) == false
    /// ```
    static func &&(_ lhs: Self, rhs: Bool) -> And<Root, Self, BoolPredicate<Self.Root>> {
        return And(lhs: lhs, rhs: BoolPredicate(value: rhs))
    }
    
    /// Applies the ``And`` operator between a boolean and a ``Predicate``
    /// - Parameters:
    ///   - lhs: A boolean
    ///   - rhs: Any predicate
    /// - Returns: An ``And`` predicate with left-hand side being a ``BoolPredicate`` with the boolean value of the `lhs` parameter, the right-hand side being the `rhs` predicate
    ///
    /// Example:
    /// ```swift
    /// let countPredicate = \Array<Int>.count == 3
    /// let and = false && countPredicate
    ///
    /// countPredicate.evaluate(instance: [1,2,3]) // true
    /// and.evaluate(instance: [1,2,3]) // (false && true) == false
    /// ```
    static func &&(_ lhs: Bool, rhs: Self) -> And<Root, BoolPredicate<Self.Root>, Self> {
        return And(lhs: BoolPredicate(value: lhs), rhs: rhs)
    }

    /// Applies the ``Or`` operator between a ``Predicate`` and a boolean
    /// - Parameters:
    ///   - lhs: Any predicate
    ///   - rhs: A boolean
    /// - Returns: An ``And`` predicate with the left-hand side being the `lhs` predicate, and the right-hand side being a ``BoolPredicate`` with the boolean value of the `rhs` parameter
    ///
    /// Example:
    /// ```swift
    /// let countPredicate = \Array<Int>.count == 3
    /// let or = countPredicate || true
    ///
    /// countPredicate.evaluate(instance: []) // false
    /// or.evaluate(instance: []) // (false || true) == true
    /// ```
    static func ||(_ lhs: Self, rhs: Bool) -> Or<Root, Self, BoolPredicate<Self.Root>> {
        return Or(lhs: lhs, rhs: BoolPredicate(value: rhs))
    }

    /// Applies the ``Or`` operator between a boolean and a ``Predicate``
    /// - Parameters:
    ///   - lhs: A boolean
    ///   - rhs: Any predicate
    /// - Returns: An ``Or`` predicate with left-hand side being a ``BoolPredicate`` with the boolean value of the `lhs` parameter, the right-hand side being the `rhs` predicate
    ///
    /// Example:
    /// ```swift
    /// let countPredicate = \Array<Int>.count == 3
    /// let or = true || countPredicate
    ///
    /// countPredicate.evaluate(instance: []) // false
    /// or.evaluate(instance: []) // (true || false) == true
    /// ```
    static func ||(_ lhs: Bool, rhs: Self) -> Or<Root, BoolPredicate<Self.Root>, Self> {
        return Or(lhs: BoolPredicate(value: lhs), rhs: rhs)
    }
}
