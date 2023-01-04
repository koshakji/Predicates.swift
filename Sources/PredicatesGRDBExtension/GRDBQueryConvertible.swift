//
//  GRDBQueryConvertible.swift
//  
//
//  Created by Majd Koshakji on 4/1/23.
//

import Predicates
import GRDB

public protocol GRDBQueryConvertible: Predicate where Root: Keyable {
    associatedtype Expression: SQLExpressible
    var grdbQuery: Expression { get }
}

