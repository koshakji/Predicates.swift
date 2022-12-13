//
//  Key.swift
//  Predicates
//
//  Created by Majd Koshakji on 14/11/22.
//

protocol Key {
    var stringValue: String { get }
}

extension String: Key {
    var stringValue: String { self }
}

extension Int: Key {
    var stringValue: String { "\(self)" }
}


protocol Keyable {
    associatedtype Keys: Key
    static var keys: [PartialKeyPath<Self>: Keys] { get }
}

extension KeyPathValuePredicate where Root: Keyable {
    func key() -> String {
        guard let key = Root.keys[keyPath]?.stringValue else {
            fatalError()
        }
        return key
    }
}
