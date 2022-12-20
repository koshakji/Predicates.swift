//
//  CollectionPredicates.swift
//  Predicates
//
//  Created by Majd Koshakji on 1/11/22.
//

public struct Contains<Root, Container>: KeyPathValuePredicate where Container: Sequence, Container.Element: Equatable {
    public let keyPath: KeyPath<Root, Container>
    public let value: Container.Element
    
    public func evaluate(instance: Root) -> Bool {
        return get(from: instance).contains(value)
    }
}

public struct ContainsSet<Root, Container>: KeyPathValuePredicate where Container: SetAlgebra {
    public let keyPath: KeyPath<Root, Container>
    public let value: Container.Element
    
    public func evaluate(instance: Root) -> Bool {
        return get(from: instance).contains(value)
    }
}

public extension KeyPath where Value: Sequence, Value.Element: Equatable {
    func contains(_ value: Value.Element, caseSensitive: Bool = true) -> Contains<Root, Value> {
        return Contains(keyPath: self, value: value)
    }
}

public extension KeyPath where Value: SetAlgebra {
    func contains(_ value: Value.Element, caseSensitive: Bool = true) -> ContainsSet<Root, Value> {
        return ContainsSet(keyPath: self, value: value)
    }
}

