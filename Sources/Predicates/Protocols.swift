//
//  Protocols.swift
//  Predicates
//
//  Created by Majd Koshakji on 1/11/22.
//


/// Base protocol for all predicates
public protocol Predicate<Root> {
    /// The type of object this predicate can evaluate
    associatedtype Root
    
    /// Evaluates whether the passed instance matches the predicate
    /// - Parameter instance: object we want to check
    /// - Returns: Bool indicating whether it matches the predicate or not
    func evaluate(instance: Root) -> Bool
}


/// Protocol for basing a predicate on a specific value
public protocol ValuePredicate<Root, Value>: Predicate {
    /// The type of value this predicate compares with
    associatedtype Value
    
    /// The value the predicate compares with
    var value: Value { get }
}


/// Protocol for basing a predicate on a value compared with a `KeyPath` on the `Root` type
public protocol KeyPathValuePredicate<Root, KeyPathValue, Value>: ValuePredicate {
    /// The type of value the `KeyPath` returns
    associatedtype KeyPathValue
    
    
    /// The `KeyPath` used to return a value from a `Root` instance
    var keyPath: KeyPath<Root, KeyPathValue> { get }
}

public extension KeyPathValuePredicate {
    
    /// Get the `KeyPath` value from an instance
    /// - Parameter instance: object being evaluated
    /// - Returns: value of the object's `KeyPath`
    func get(from instance: Root) -> KeyPathValue {
        return instance[keyPath: self.keyPath]
    }
}


/// Protocol for predicate operators that work on one base predicate (e.g. `Not`)
public protocol UnaryPredicateOperator<Root, Base>: Predicate {
    /// Type of base predicate that the operator is being applied on
    associatedtype Base: Predicate<Root>
    
    /// The base predicate the operator is being applied on
    var basePredicate: Base { get }
}


/// Protocol for predicate operators that work on two base predicates (e.g. `And`)
public protocol BinaryPredicateOperator<Root>: Predicate {
    /// Type of the left-hand side base predicate the operator is applied on
    associatedtype LHS: Predicate<Root>
    
    /// Type of the right-hand side base predicate the operator is applied on
    associatedtype RHS: Predicate<Root>
    
    
    /// Left-hand side predicate the operator is being applied on
    var lhs: LHS { get }
    
    /// Right-hand side predicate the operator is being applied on
    var rhs: RHS { get }
}

public extension Collection {
    
    /// Filter any collection by matching each element against the predicate
    /// - Parameter predicate: The predicate we want elements to match
    /// - Returns: An array of elements that satisfy the predicate
    func filter(_ predicate: any Predicate<Element>) -> [Element] {
        return self.filter(predicate.evaluate(instance:))
    }
}

