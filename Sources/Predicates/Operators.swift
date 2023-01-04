//
//  Operators.swift
//  Predicates
//
//  Created by Majd Koshakji on 1/11/22.
//


/// Negates the base predicate
///
/// - If the wrapped base predicate evaluates to `true`, this predicate would evaluate to `false`.
/// - If the wrapped  base predicate evaluates to `false`, this predicate would evaluate to `true`
///
/// Mostly used by using the ``!`` operator on the base predicate
///
/// Example:
/// ```swift
/// let predicate = \Array<Int>.count == 3
/// let negation = !predicate
///
/// predicate.evaluate(instance: [1,2,3]) // true
/// negation.evaluate(instance: [1,2,3]) // false
///
/// predicate.evaluate(instance: [1,2]) // false
/// negation.evaluate(instance: [1,2]) // true
/// ```
public struct Not<Root, Base>: UnaryPredicateOperator where Base: Predicate, Base.Root == Root {
    
    /// The base predicate that's being negated
    public let basePredicate: Base

    public func evaluate(instance: Root) -> Bool {
        return !self.basePredicate.evaluate(instance: instance)
    }
}



/// Applies a binary `and` operation between the two base predicates
///
/// - If both wrapped base predicates evaluate to `true`, this predicate would evaluate to `true`
/// - If either one of the base predicates evaluate to `false`, this predicate would evaluate to `false`
/// - If both base predicates evaluate to `false`, this predicate would evaluate to `false` as well.
///
/// - Note: Both base predicates must have the same ``Root`` type
///
/// Mostly used by using the ``&&`` operator on the two base predicates
///
/// Example:
/// ```swift
/// let countPredicate = \Array<Int>.count == 3
/// let firstPredicate = \Array<Int>.first == 1
/// let and = countPredicate && firstPredicate
///
/// countPredicate.evaluate(instance: [1,2,3]) // true
/// firstPredicate.evaluate(instance: [1,2,3]) // true
/// and.evaluate(instance: [1,2,3]) // true
///
/// countPredicate.evaluate(instance: [1,3]) // false
/// firstPredicate.evaluate(instance: [1,3]) // true
/// and.evaluate(instance: [1,3]) // true
/// ```
public struct And<Root, LHS, RHS>: BinaryPredicateOperator where LHS: Predicate<Root>, RHS: Predicate<Root> {
    public let lhs: LHS
    public let rhs: RHS

    public func evaluate(instance: Root) -> Bool {
        return self.lhs.evaluate(instance: instance) && self.rhs.evaluate(instance: instance)
    }
}


/// Applies a binary `or` operation between the two base predicates
///
/// - If either wrapped base predicates evaluate to `true`, this predicate would evaluate to `true`
/// - If both wrapped base predicates evaluate to `true`, this prediate would evaluate to `true`.
/// - If both base predicates evaluate to `false`, this predicate would evaluate to `false`.
///
/// - Note: Both base predicates must have the same `Root` type
///
/// Mostly used by using the ``||`` operator on the two base predicates
///
/// Example:
/// ```swift
/// let countPredicate = \Array<Int>.count == 3
/// let firstPredicate = \Array<Int>.first == 1
/// let or = countPredicate || firstPredicate
///
/// countPredicate.evaluate(instance: [2,2,3]) // true
/// firstPredicate.evaluate(instance: [2,2,3]) // false
/// or.evaluate(instance: [2,2,3]) // true
///
/// countPredicate.evaluate(instance: [2,3]) // false
/// firstPredicate.evaluate(instance: [2,3]) // false
/// or.evaluate(instance: [2,3]) // false
/// ```
public struct Or<Root, LHS, RHS>: BinaryPredicateOperator where LHS: Predicate<Root>, RHS: Predicate<Root> {
    public let lhs: LHS
    public let rhs: RHS

    public func evaluate(instance: Root) -> Bool {
        return self.lhs.evaluate(instance: instance) || self.rhs.evaluate(instance: instance)
    }
}

public extension Predicate {
    /// Applies the ``And`` operator between two base ``Predicate``s
    /// - Parameters:
    ///   - lhs: Any predicate
    ///   - rhs: Any predicate
    /// - Returns: An ``And`` predicate applied on the `lhs` and `rhs` predicates
    /// - Example: See ``And`` example
    static func &&<RHS: Predicate<Root>>(_ lhs: Self, rhs: RHS) -> And<Root, Self, RHS> {
        return And(lhs: lhs, rhs: rhs)
    }

    /// Applies the ``Or`` operator between two base ``Predicate``s
    /// - Parameters:
    ///   - lhs: Any predicate
    ///   - rhs: Any predicate
    /// - Returns: An ``Or`` predicate applied on the `lhs` and `rhs` predicates
    /// - Example: See ``Or`` example
    static func ||<RHS: Predicate<Root>>(_ lhs: Self, rhs: RHS) -> Or<Root, Self, RHS> {
        return Or(lhs: lhs, rhs: rhs)
    }
    
    /// Applies the ``Not`` operator on a base ``Predicate``.
    /// - Parameters:
    ///   - predicate: The base predicate
    /// - Returns: A ``Not`` predicate negating the passed base predicate
    /// - Example: See ``Not`` example
    static prefix func !(_ predicate: Self) -> Not<Root, Self> {
        return Not(basePredicate: predicate)
    }
}
