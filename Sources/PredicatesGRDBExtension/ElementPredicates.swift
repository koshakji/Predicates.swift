//
//  ElementPredicates.swift
//  
//
//  Created by Majd Koshakji on 4/1/23.
//

import Predicates
import GRDB

extension Equals: GRDBQueryConvertible where Root: Keyable, Value: SQLExpressible {
    public var grdbQuery: some SQLExpressible {
        return Column(key()) == self.value
    }
}

extension GreaterThan: GRDBQueryConvertible where Root: Keyable, Value: SQLExpressible {
    public var grdbQuery: some SQLExpressible {
        return Column(key()) > self.value
    }
}

extension LessThan: GRDBQueryConvertible where Root: Keyable, Value: SQLExpressible {
    public var grdbQuery: some SQLExpressible {
        return Column(key()) < self.value
    }
}

extension GreaterThanOrEqual: GRDBQueryConvertible where Root: Keyable, Value: SQLExpressible {
    public var grdbQuery: some SQLExpressible {
        return Column(key()) >= self.value
    }
}

extension LessThanOrEqual: GRDBQueryConvertible where Root: Keyable, Value: SQLExpressible {
    public var grdbQuery: some SQLExpressible {
        return Column(key()) <= self.value
    }
}
