//
//  File.swift
//  
//
//  Created by Majd Koshakji on 4/1/23.
//

import Predicates
import GRDB

extension BoolPredicate: GRDBQueryConvertible where Root: Keyable {
    public var grdbQuery: some SQLExpressible {
        return self.value
    }
}

