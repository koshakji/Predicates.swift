//
//  DatePredicates.swift
//  Predicates
//
//  Created by Majd Koshakji on 1/11/22.
//

import Foundation

public protocol DateKeyPathValuePredicate: KeyPathValuePredicate where KeyPathValue == Date {
    var calendar: Calendar { get }
}

public extension DateKeyPathValuePredicate {
    func getComponent(component: Calendar.Component, from instance: Root) -> Int {
        let date = self.get(from: instance)
        return calendar.component(component, from: date)
    }
}

public struct Year<Root>: DateKeyPathValuePredicate {
    public var keyPath: KeyPath<Root, Date>
    public let value: Int
    public let calendar: Calendar
    
    public init(keyPath: KeyPath<Root, Date>, value: Int, calendar: Calendar = .current) {
        self.value = value
        self.keyPath = keyPath
        self.calendar = calendar
    }
    
    public func evaluate(instance: Root) -> Bool {
        return self.getComponent(component: .year, from: instance) == value
    }
}

public struct Month<Root>: DateKeyPathValuePredicate {
    public var keyPath: KeyPath<Root, Date>
    public let value: Int
    public let calendar: Calendar
    
    public init(keyPath: KeyPath<Root, Date>, value: Int, calendar: Calendar = .current) {
        self.value = value
        self.keyPath = keyPath
        self.calendar = calendar
    }
    
    public func evaluate(instance: Root) -> Bool {
        return self.getComponent(component: .month, from: instance) == value
    }
}


public struct Day<Root>: DateKeyPathValuePredicate {
    public var keyPath: KeyPath<Root, Date>
    public let value: Int
    public let calendar: Calendar
    
    public init(keyPath: KeyPath<Root, Date>, value: Int, calendar: Calendar = .current) {
        self.value = value
        self.keyPath = keyPath
        self.calendar = calendar
    }
    
    public func evaluate(instance: Root) -> Bool {
        return self.getComponent(component: .day, from: instance) == value
    }
}


public extension KeyPath where Value == Date {
    func year(equals value: Int, calendar: Calendar = .current) -> Year<Root> {
        return Year(keyPath: self, value: value, calendar: calendar)
    }
    
    func month(equals value: Int, calendar: Calendar = .current) -> Month<Root> {
        return Month(keyPath: self, value: value, calendar: calendar)
    }
    
    func day(equals value: Int, calendar: Calendar = .current) -> Day<Root> {
        return Day(keyPath: self, value: value, calendar: calendar)
    }
    
}
