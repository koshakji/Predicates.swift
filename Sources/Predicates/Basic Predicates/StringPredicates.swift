//
//  StringPredicates.swift
//  Predicates
//
//  Created by Majd Koshakji on 1/11/22.
//

public struct StringContains<Root>: KeyPathValuePredicate {
    public let keyPath: KeyPath<Root, String>
    public let value: String
    public let caseSensitive: Bool
    
    public func evaluate(_ instance: Root) -> Bool {
        let string = getKeyPathValue(from: instance)
        if caseSensitive {
            return string.contains(value)
        } else {
            return string.uppercased().contains(value.uppercased())
        }
    }
}

public struct HasPrefix<Root>: KeyPathValuePredicate {
    public let keyPath: KeyPath<Root, String>
    public let value: String
    
    public func evaluate(_ instance: Root) -> Bool {
        return getKeyPathValue(from: instance).hasPrefix(value)
    }
}

public struct HasSuffix<Root>: KeyPathValuePredicate {
    public let keyPath: KeyPath<Root, String>
    public let value: String
    
    public func evaluate(_ instance: Root) -> Bool {
        return getKeyPathValue(from: instance).hasSuffix(value)
    }
}


@available(macOS 13.0, *)
@available(iOS 16, *)
public struct MatchesRegex<Root, Value>: KeyPathValuePredicate where Value: RegexComponent {
    public let keyPath: KeyPath<Root, String>
    public let value: Value
    
    public func evaluate(_ instance: Root) -> Bool {
        return getKeyPathValue(from: instance).contains(value)
    }
}

public extension KeyPath where Value == String {
    func contains(_ substring: String, caseSensitive: Bool = true) -> StringContains<Root> {
        return StringContains(keyPath: self, value: substring, caseSensitive: caseSensitive)
    }
    
    func hasPrefix(_ prefix: String) -> HasPrefix<Root> {
        return HasPrefix(keyPath: self, value: prefix)
    }
    
    func hasSuffix(_ suffix: String) -> HasSuffix<Root> {
        return HasSuffix(keyPath: self, value: suffix)
    }
    
    @available(macOS 13.0, *)
    @available(iOS 16, *)
    func matches<Regex: RegexComponent>(regex: Regex) -> MatchesRegex<Root, Regex> {
        return MatchesRegex(keyPath: self, value: regex)
    }
}
