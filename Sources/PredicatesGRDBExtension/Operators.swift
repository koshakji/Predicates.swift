//
//  Operators.swift
//  
//
//  Created by Majd Koshakji on 4/1/23.
//

import Predicates
import GRDB

extension Not: GRDBQueryConvertible where Root: Keyable, Base: GRDBQueryConvertible {
    public var grdbQuery: some SQLExpressible {
        return !self.basePredicate.grdbQuery.sqlExpression
    }
}

extension And: GRDBQueryConvertible where LHS: GRDBQueryConvertible, RHS: GRDBQueryConvertible {
    public var grdbQuery: some SQLExpressible {
        return self.lhs.grdbQuery.sqlExpression && self.rhs.grdbQuery.sqlExpression
    }
}

extension Or: GRDBQueryConvertible where LHS: GRDBQueryConvertible, RHS: GRDBQueryConvertible {
    public var grdbQuery: some SQLExpressible {
        return self.lhs.grdbQuery.sqlExpression || self.rhs.grdbQuery.sqlExpression
    }
}

