//
//  Key.swift
//  Predicates
//
//  Created by Majd Koshakji on 14/11/22.
//

public protocol Key {
    var stringValue: String { get }
}

extension String: Key {
    public var stringValue: String { self }
}

extension Int: Key {
    public var stringValue: String { "\(self)" }
}


public protocol Keyable {
    associatedtype Keys: Key
    static var keys: [PartialKeyPath<Self>: Keys] { get }
}

extension KeyPathValuePredicate where Root: Keyable {
    public func key() -> String {
        guard let key = Root.keys[keyPath]?.stringValue else {
            fatalError()
        }
        return key
    }
}
