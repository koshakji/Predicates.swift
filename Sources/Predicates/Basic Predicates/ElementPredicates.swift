//
//  ElementPredicates.swift
//  Predicates
//
//  Created by Majd Koshakji on 1/11/22.
//

/// A ``KeyPathValuePredicate`` that checks for equality between the instance's keyPath value and the provided value
/// - Evaluates to `instance[keyPath: self.keyPath] == self.value`
/// - Note: The ``Value`` type must be ``Equatable``.
public struct Equals<Root, Value>: KeyPathValuePredicate where Value: Equatable {
    public let keyPath: KeyPath<Root, Value>
    public let value: Value
    
    public func evaluate(instance: Root) -> Bool {
        return self.get(from: instance) == self.value
    }
}


/// A ``KeyPathValuePredicate`` that checks for if the instance's keyPath value is greater than the provided value
/// - Evaluates to `instance[keyPath: self.keyPath] > self.value`
/// - Note: The ``Value`` type must be ``Comparable``.
public struct GreaterThan<Root, Value>: KeyPathValuePredicate where Value: Comparable {
    public let keyPath: KeyPath<Root, Value>
    public let value: Value
    
    public func evaluate(instance: Root) -> Bool {
        return self.get(from: instance) > self.value
    }
}


/// A ``KeyPathValuePredicate`` that checks for if the instance's keyPath value is less than the provided value
/// - Evaluates to `instance[keyPath: self.keyPath] < self.value`
/// - Note: The ``Value`` type must be ``Comparable``.
public struct LessThan<Root, Value>: KeyPathValuePredicate where Value: Comparable {
    public let keyPath: KeyPath<Root, Value>
    public let value: Value
    
    public func evaluate(instance: Root) -> Bool {
        return self.get(from: instance) < self.value
    }
}


/// A ``KeyPathValuePredicate`` that checks for if the instance's keyPath value is greater than or equal the provided value
/// - Evaluates to `instance[keyPath: self.keyPath] >= self.value`
/// - Note: The ``Value`` type must be ``Comparable`` and ``Equatable``.
public struct GreaterThanOrEqual<Root, Value>: KeyPathValuePredicate where Value: Comparable, Value: Equatable {
    public let keyPath: KeyPath<Root, Value>
    public let value: Value
    
    public func evaluate(instance: Root) -> Bool {
        return self.get(from: instance) >= self.value
    }
}

/// A ``KeyPathValuePredicate`` that checks for if the instance's keyPath value is less than or equal the provided value
/// - Evaluates to `instance[keyPath: self.keyPath] <= self.value`
/// - Note: The ``Value`` type must be ``Comparable`` and ``Equatable``.
public struct LessThanOrEqual<Root, Value>: KeyPathValuePredicate where Value: Comparable {
    public let keyPath: KeyPath<Root, Value>
    public let value: Value
    
    public func evaluate(instance: Root) -> Bool {
        return self.get(from: instance) <= self.value
    }
}



/// A ``KeyPathValuePredicate`` that checks for if the instance's keyPath value is within the bounds of the provided range
/// - Evaluates to `self.value.contains(instance[keyPath: self.keyPath]`
public struct InRange<Root, ValueRange>: KeyPathValuePredicate where ValueRange: RangeExpression {
    public let keyPath: KeyPath<Root, ValueRange.Bound>
    public let value: ValueRange
    
    public func evaluate(instance: Root) -> Bool {
        return self.value.contains(self.get(from: instance))
    }
    
}

public extension KeyPath where Value: Equatable {
    /// Builds an ``Equals`` predicate
    /// - Parameters:
    ///   - rhs: keyPath to get the instance value
    ///   - lhs: value we want to check whether the instance value equals
    /// - Returns: ``Equals`` predicate comparing the keyPath and the value
    ///
    /// Example:
    /// ```swift
    /// let predicate = \Array<Int>.count == 3
    ///
    /// predicate.evaluate(instance: [1,2,3]) // true
    /// predicate.evaluate(instance: [1,2]) // false
    /// ```
    static func ==(_ rhs: KeyPath<Root, Value>, _ lhs: Value) -> Equals<Root, Value> {
        return Equals(keyPath: rhs, value: lhs)
    }
}

public extension KeyPath where Value: Comparable {
    /// Builds a ``GreaterThan`` predicate
    /// - Parameters:
    ///   - rhs: keyPath to get the instance value
    ///   - lhs: value we want to check whether the instance value is greater than
    /// - Returns: ``GreaterThan`` predicate comparing the keyPath and the value
    ///
    /// Example:
    /// ```swift
    /// let predicate = \Array<Int>.count > 3
    ///
    /// predicate.evaluate(instance: [1,2,3,4]) // true
    /// predicate.evaluate(instance: [1,2,3]) // false
    /// ```
    static func >(_ rhs: KeyPath<Root, Value>, _ lhs: Value) -> GreaterThan<Root, Value> {
        return GreaterThan(keyPath: rhs, value: lhs)
    }

    /// Builds a ``LessThan`` predicate
    /// - Parameters:
    ///   - rhs: keyPath to get the instance value
    ///   - lhs: value we want to check whether the instance value is greater than
    /// - Returns: ``LessThan`` predicate comparing the keyPath and the value
    ///
    /// Example:
    /// ```swift
    /// let predicate = \Array<Int>.count < 3
    ///
    /// predicate.evaluate(instance: [1,2]) // true
    /// predicate.evaluate(instance: [1,2,3]) // false
    /// ```
    static func <(_ rhs: KeyPath<Root, Value>, _ lhs: Value) -> LessThan<Root, Value> {
        return LessThan(keyPath: rhs, value: lhs)
    }
    
    /// Builds an ``InRange`` predicate
    /// - Parameters:
    ///   - range: range we want to check whether the keyPath is within
    /// - Returns: ``InRange`` predicate comparing the keyPath (`self`) and the value
    ///
    /// Example:
    /// ```swift
    /// let predicate = (\Array<Int>.count).isIn(range: 2...4)
    ///
    /// predicate.evaluate(instance: [1,2]) // true
    /// predicate.evaluate(instance: [1,2,3,4]) // true
    /// predicate.evaluate(instance: []) // false
    /// predicate.evaluate(instance: [1,2,3,4,5]) // false
    /// ```
    func isIn<R: RangeExpression>(range: R) -> InRange<Root, R> where R.Bound == Value {
        return InRange(keyPath: self, value: range)
    }
}


public extension KeyPath where Value: Comparable, Value: Equatable {
    /// Builds a ``GreaterThanOrEqual`` predicate
    /// - Parameters:
    ///   - rhs: keyPath to get the instance value
    ///   - lhs: value we want to check whether the instance value is greater than
    /// - Returns: ``GreaterThanOrEqual`` predicate comparing the keyPath and the value
    ///
    /// Example:
    /// ```swift
    /// let predicate = \Array<Int>.count >= 3
    ///
    /// predicate.evaluate(instance: [1,2,3,4]) // true
    /// predicate.evaluate(instance: [1,2,3]) // true
    /// predicate.evaluate(instance: [1,2]) // false
    /// ```
    static func >=(_ rhs: KeyPath<Root, Value>, _ lhs: Value) -> GreaterThanOrEqual<Root, Value> {
        return GreaterThanOrEqual(keyPath: rhs, value: lhs)
    }

    /// Builds a ``LessThanOrEqual`` predicate
    /// - Parameters:
    ///   - rhs: keyPath to get the instance value
    ///   - lhs: value we want to check whether the instance value is greater than
    /// - Returns: ``LessThanOrEqual`` predicate comparing the keyPath and the value
    ///
    /// Example:
    /// ```swift
    /// let predicate = \Array<Int>.count <= 3
    ///
    /// predicate.evaluate(instance: [1,2]) // true
    /// predicate.evaluate(instance: [1,2,3]) // true
    /// predicate.evaluate(instance: [1,2,3,4]) // false
    /// ```
    static func <=(_ rhs: KeyPath<Root, Value>, _ lhs: Value) -> LessThanOrEqual<Root, Value> {
        return LessThanOrEqual(keyPath: rhs, value: lhs)
    }
}

