//
//  CustomPredicate.swift
//  Predicates
//
//  Created by Majd Koshakji on 1/11/22.
//

public struct CustomPredicate<Root, Value>: ValuePredicate {
    
    public let origin: (Root) -> Value
    
    public let value: Value
    public let compare: (Value, Value) -> Bool
    public func evaluate(_ instance: Root) -> Bool {
        return self.compare(origin(instance), self.value)
    }
}
