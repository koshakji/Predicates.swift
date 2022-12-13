//
//  CustomPredicate.swift
//  Predicates
//
//  Created by Majd Koshakji on 1/11/22.
//

struct CustomPredicate<Root, Value>: Predicate {
    let origin: (Root) -> Value
    let value: Value
    
    let compare: (Value, Value) -> Bool
    
    func evaluate(instance: Root) -> Bool {
        return self.compare(origin(instance), self.value)
    }
}
