//
//  Key.swift
//  Predicates
//
//  Created by Majd Koshakji on 14/11/22.
//


/// Protocol for a type used as a key
public protocol Key {
    
    /// The string value that will be used as an actual key in string-based predicate conversions.
    var stringValue: String { get }
}

extension Key where Self: RawRepresentable, Self.RawValue == String {
    public var stringValue: String { rawValue }
}

public protocol Keyable {
    /// The `Key` type used for this type
    associatedtype Keys: Key
    
    
    /// A static dictionary that maps every keyPath to a single key
    ///
    /// This will be used in predicate conversions to get the string-based name of keyPaths
    /// used in the converted predicate
    static var keys: [PartialKeyPath<Self>: Keys] { get }
}

extension KeyPathValuePredicate where Root: Keyable {
    
    /// Get the string key of the predicate `keyPath` from a `Keyable` root type
    /// - Returns: key to be used in string-based predicate conversions
    public func key() -> String {
        guard let key = Root.keys[keyPath]?.stringValue else {
            fatalError()
        }
        return key
    }
}
