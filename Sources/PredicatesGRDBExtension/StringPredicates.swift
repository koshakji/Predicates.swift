//
//  StringPredicates.swift
//  
//
//  Created by Majd Koshakji on 4/1/23.
//

import Predicates
import GRDB

extension StringContains: GRDBQueryConvertible where Root: Keyable {
    public var grdbQuery: some SQLExpressible {
        let column = Column(key())
        if self.caseSensitive {
            return column.like("%\(self.value)%")
        } else {
            return column.uppercased.like(("%\(self.value.uppercased())%"))
        }
    }
}

extension HasPrefix: GRDBQueryConvertible where Root: Keyable {
    public var grdbQuery: some SQLExpressible {
        return Column(key()).like("\(self.value)%")
    }
}

extension HasSuffix: GRDBQueryConvertible where Root: Keyable {
    public var grdbQuery: some SQLExpressible {
        return Column(key()).like("%\(self.value)")
    }
}

