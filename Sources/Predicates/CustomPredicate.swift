//
//  CustomPredicate.swift
//  Predicates
//
//  Created by Majd Koshakji on 1/11/22.
//

public struct CustomPredicate<Root, Value>: ValuePredicate {
    
    /// A closure used to get a comparable ``Value`` from a ``Root`` instance
    public let origin: (Root) -> Value
    
    public let value: Value
    
    
    /// A closure to compare the ``Value`` coming from the evaluated instance and  ``value``
    public let compare: (Value, Value) -> Bool
    
    public func evaluate(instance: Root) -> Bool {
        return self.compare(origin(instance), self.value)
    }
}
