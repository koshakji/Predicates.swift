//
//  Key.swift
//  Predicates
//
//  Created by Majd Koshakji on 14/11/22.
//

public protocol Key {
    var stringValue: String { get }
}

extension Key where Self: RawRepresentable, Self.RawValue == String {
    public var stringValue: String { rawValue }
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
