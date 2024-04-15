//
//  ElementPredicates.swift
//  Predicates
//
//  Created by Majd Koshakji on 1/11/22.
//

public struct Equals<Root, Value>: KeyPathValuePredicate where Value: Equatable {
    public let keyPath: KeyPath<Root, Value>
    public let value: Value
    
    public func evaluate(_ instance: Root) -> Bool {
        return self.getKeyPathValue(from: instance) == self.value
    }
}


public struct GreaterThan<Root, Value>: KeyPathValuePredicate where Value: Comparable {
    public let keyPath: KeyPath<Root, Value>
    public let value: Value
    
    public func evaluate(_ instance: Root) -> Bool {
        return self.getKeyPathValue(from: instance) > self.value
    }
}


public struct LessThan<Root, Value>: KeyPathValuePredicate where Value: Comparable {
    public let keyPath: KeyPath<Root, Value>
    public let value: Value
    
    public func evaluate(_ instance: Root) -> Bool {
        return self.getKeyPathValue(from: instance) < self.value
    }
}


public struct GreaterThanOrEqual<Root, Value>: KeyPathValuePredicate where Value: Comparable, Value: Equatable {
    public let keyPath: KeyPath<Root, Value>
    public let value: Value
    
    public func evaluate(_ instance: Root) -> Bool {
        return self.getKeyPathValue(from: instance) >= self.value
    }
}

public struct LessThanOrEqual<Root, Value>: KeyPathValuePredicate where Value: Comparable {
    public let keyPath: KeyPath<Root, Value>
    public let value: Value
    
    public func evaluate(_ instance: Root) -> Bool {
        return self.getKeyPathValue(from: instance) <= self.value
    }
}



public struct InRange<Root, ValueRange>: KeyPathValuePredicate where ValueRange: RangeExpression {
    public let keyPath: KeyPath<Root, ValueRange.Bound>
    public let value: ValueRange
    
    public func evaluate(_ instance: Root) -> Bool {
        return self.value.contains(self.getKeyPathValue(from: instance))
    }
    
}

public extension KeyPath where Value: Equatable {
    static func ==(_ rhs: KeyPath<Root, Value>, _ lhs: Value) -> Equals<Root, Value> {
        return Equals(keyPath: rhs, value: lhs)
    }
}

public extension KeyPath where Value: Comparable {
    static func >(_ rhs: KeyPath<Root, Value>, _ lhs: Value) -> GreaterThan<Root, Value> {
        return GreaterThan(keyPath: rhs, value: lhs)
    }

    static func <(_ rhs: KeyPath<Root, Value>, _ lhs: Value) -> LessThan<Root, Value> {
        return LessThan(keyPath: rhs, value: lhs)
    }
    
    func isIn<R: RangeExpression>(range: R) -> InRange<Root, R> where R.Bound == Value {
        return InRange(keyPath: self, value: range)
    }
}


public extension KeyPath where Value: Comparable, Value: Equatable {
    static func >=(_ rhs: KeyPath<Root, Value>, _ lhs: Value) -> GreaterThanOrEqual<Root, Value> {
        return GreaterThanOrEqual(keyPath: rhs, value: lhs)
    }

    static func <=(_ rhs: KeyPath<Root, Value>, _ lhs: Value) -> LessThanOrEqual<Root, Value> {
        return LessThanOrEqual(keyPath: rhs, value: lhs)
    }
}

