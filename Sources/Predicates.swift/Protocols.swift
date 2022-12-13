//
//  Protocols.swift
//  Predicates
//
//  Created by Majd Koshakji on 1/11/22.
//


public protocol Predicate<Root> {
    associatedtype Root
    func evaluate(instance: Root) -> Bool
}

public protocol ValuePredicate<Root, Value>: Predicate {
    associatedtype Value
    var value: Value { get }
}

public protocol KeyPathValuePredicate<Root, KeyPathValue, Value>: ValuePredicate {
    associatedtype KeyPathValue
    var keyPath: KeyPath<Root, KeyPathValue> { get }
}

public extension KeyPathValuePredicate {
    func get(from instance: Root) -> KeyPathValue {
        return instance[keyPath: self.keyPath]
    }
}

public protocol UnaryPredicateOperator<Root, Base>: Predicate {
    associatedtype Base: Predicate<Root>
    var basePredicate: Base { get }
}

public protocol BinaryPredicateOperator<Root>: Predicate {
    associatedtype LHS: Predicate<Root>
    associatedtype RHS: Predicate<Root>
    
    var lhs: LHS { get }
    var rhs: RHS { get }
}

public extension Collection {
    func filter(_ predicate: any Predicate<Element>) -> [Element] {
        return self.filter(predicate.evaluate(instance:))
    }
}

