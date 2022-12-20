import XCTest
@testable import Predicates

struct NestedThing: Comparable, Equatable {
    let nestedInteger: Int
    
    static func < (lhs: NestedThing, rhs: NestedThing) -> Bool {
        return lhs.nestedInteger < rhs.nestedInteger
    }
    
    static func == (lhs: NestedThing, rhs: NestedThing) -> Bool {
        return lhs.nestedInteger == rhs.nestedInteger
    }
}

struct Something {
    let integer: Int
    let string: String
    let array: [Int]
    let nested: NestedThing
}

final class PredicatesTests: XCTestCase {
    let object = Something(
        integer: 1,
        string: "hello world",
        array: [1,4,6],
        nested: .init(nestedInteger: 8)
    )
    
    func testEquality() throws {
        let trueIntegerPredicate = \Something.integer == 1
        let trueStringPredicate = \Something.string == "hello world"
        let trueArrayPredicate = \Something.array == [1,4,6]
        let trueNestedIntegerPredicate = \Something.nested.nestedInteger == 8
        let trueObjectPredicate = \Something.nested == NestedThing(nestedInteger: 8)
        
        XCTAssertTrue(trueIntegerPredicate.evaluate(instance: object))
        XCTAssertTrue(trueStringPredicate.evaluate(instance: object))
        XCTAssertTrue(trueArrayPredicate.evaluate(instance: object))
        XCTAssertTrue(trueNestedIntegerPredicate.evaluate(instance: object))
        XCTAssertTrue(trueObjectPredicate.evaluate(instance: object))
        
        let falseIntegerPredicate = \Something.integer == 2
        let falseStringPredicate = \Something.string == "hello"
        let falseArrayPredicate = \Something.array == [1,4,8]
        let falseNestedIntegerPredicate = \Something.nested.nestedInteger == 5
        let falseObjectPredicate = \Something.nested == NestedThing(nestedInteger: 5)
        
        
        XCTAssertFalse(falseIntegerPredicate.evaluate(instance: object))
        XCTAssertFalse(falseStringPredicate.evaluate(instance: object))
        XCTAssertFalse(falseArrayPredicate.evaluate(instance: object))
        XCTAssertFalse(falseNestedIntegerPredicate.evaluate(instance: object))
        XCTAssertFalse(falseObjectPredicate.evaluate(instance: object))
    }
    
    func testGreaterThan() throws {
        let trueIntegerPredicate = \Something.integer > 0
        let trueStringPredicate = \Something.string > "gello world"
        let trueNestedIntegerPredicate = \Something.nested.nestedInteger > 5
        let trueObjectPredicate = \Something.nested > NestedThing(nestedInteger: 5)
        
        XCTAssertTrue(trueIntegerPredicate.evaluate(instance: object))
        XCTAssertTrue(trueStringPredicate.evaluate(instance: object))
        XCTAssertTrue(trueNestedIntegerPredicate.evaluate(instance: object))
        XCTAssertTrue(trueObjectPredicate.evaluate(instance: object))
        
        let falseIntegerPredicate = \Something.integer > 2
        let falseStringPredicate = \Something.string > "iello"
        let falseNestedIntegerPredicate = \Something.nested.nestedInteger > 10
        let falseObjectPredicate = \Something.nested > NestedThing(nestedInteger: 10)
        
        XCTAssertFalse(falseIntegerPredicate.evaluate(instance: object))
        XCTAssertFalse(falseStringPredicate.evaluate(instance: object))
        XCTAssertFalse(falseNestedIntegerPredicate.evaluate(instance: object))
        XCTAssertFalse(falseObjectPredicate.evaluate(instance: object))
    }
    
    func testLessThan() throws {
        let trueIntegerPredicate = \Something.integer < 2
        let trueStringPredicate = \Something.string < "iello"
        let trueNestedIntegerPredicate = \Something.nested.nestedInteger < 10
        let trueObjectPredicate = \Something.nested < NestedThing(nestedInteger: 10)
        
        XCTAssertTrue(trueIntegerPredicate.evaluate(instance: object))
        XCTAssertTrue(trueStringPredicate.evaluate(instance: object))
        XCTAssertTrue(trueNestedIntegerPredicate.evaluate(instance: object))
        XCTAssertTrue(trueObjectPredicate.evaluate(instance: object))
        
        let falseIntegerPredicate = \Something.integer < 0
        let falseStringPredicate = \Something.string < "gello"
        let falseNestedIntegerPredicate = \Something.nested.nestedInteger < 5
        let falseObjectPredicate = \Something.nested < NestedThing(nestedInteger: 5)
        
        XCTAssertFalse(falseIntegerPredicate.evaluate(instance: object))
        XCTAssertFalse(falseStringPredicate.evaluate(instance: object))
        XCTAssertFalse(falseNestedIntegerPredicate.evaluate(instance: object))
        XCTAssertFalse(falseObjectPredicate.evaluate(instance: object))
    }
    
    func testGreaterThanOrEqual() throws {
        var trueIntegerPredicate = \Something.integer >= 0
        var trueStringPredicate = \Something.string >= "gello world"
        var trueNestedIntegerPredicate = \Something.nested.nestedInteger >= 5
        var trueObjectPredicate = \Something.nested >= NestedThing(nestedInteger: 5)
        
        XCTAssertTrue(trueIntegerPredicate.evaluate(instance: object))
        XCTAssertTrue(trueStringPredicate.evaluate(instance: object))
        XCTAssertTrue(trueNestedIntegerPredicate.evaluate(instance: object))
        XCTAssertTrue(trueObjectPredicate.evaluate(instance: object))
        
        trueIntegerPredicate = \Something.integer >= 1
        trueStringPredicate = \Something.string >= "hello world"
        trueNestedIntegerPredicate = \Something.nested.nestedInteger >= 8
        trueObjectPredicate = \Something.nested >= NestedThing(nestedInteger: 8)
        
        XCTAssertTrue(trueIntegerPredicate.evaluate(instance: object))
        XCTAssertTrue(trueStringPredicate.evaluate(instance: object))
        XCTAssertTrue(trueNestedIntegerPredicate.evaluate(instance: object))
        XCTAssertTrue(trueObjectPredicate.evaluate(instance: object))
        
        let falseIntegerPredicate = \Something.integer >= 2
        let falseStringPredicate = \Something.string >= "iello"
        let falseNestedIntegerPredicate = \Something.nested.nestedInteger >= 10
        let falseObjectPredicate = \Something.nested >= NestedThing(nestedInteger: 10)
        
        XCTAssertFalse(falseIntegerPredicate.evaluate(instance: object))
        XCTAssertFalse(falseStringPredicate.evaluate(instance: object))
        XCTAssertFalse(falseNestedIntegerPredicate.evaluate(instance: object))
        XCTAssertFalse(falseObjectPredicate.evaluate(instance: object))
    }
    
    func testLessThanOrEqual() throws {
        var trueIntegerPredicate = \Something.integer <= 2
        var trueStringPredicate = \Something.string <= "iello"
        var trueNestedIntegerPredicate = \Something.nested.nestedInteger <= 10
        var trueObjectPredicate = \Something.nested <= NestedThing(nestedInteger: 10)
        
        XCTAssertTrue(trueIntegerPredicate.evaluate(instance: object))
        XCTAssertTrue(trueStringPredicate.evaluate(instance: object))
        XCTAssertTrue(trueNestedIntegerPredicate.evaluate(instance: object))
        XCTAssertTrue(trueObjectPredicate.evaluate(instance: object))
        
        trueIntegerPredicate = \Something.integer <= 1
        trueStringPredicate = \Something.string <= "hello world"
        trueNestedIntegerPredicate = \Something.nested.nestedInteger <= 8
        trueObjectPredicate = \Something.nested <= NestedThing(nestedInteger: 8)
        
        XCTAssertTrue(trueIntegerPredicate.evaluate(instance: object))
        XCTAssertTrue(trueStringPredicate.evaluate(instance: object))
        XCTAssertTrue(trueNestedIntegerPredicate.evaluate(instance: object))
        XCTAssertTrue(trueObjectPredicate.evaluate(instance: object))
        
        let falseIntegerPredicate = \Something.integer <= 0
        let falseStringPredicate = \Something.string <= "gello"
        let falseNestedIntegerPredicate = \Something.nested.nestedInteger <= 5
        let falseObjectPredicate = \Something.nested <= NestedThing(nestedInteger: 5)
        
        XCTAssertFalse(falseIntegerPredicate.evaluate(instance: object))
        XCTAssertFalse(falseStringPredicate.evaluate(instance: object))
        XCTAssertFalse(falseNestedIntegerPredicate.evaluate(instance: object))
        XCTAssertFalse(falseObjectPredicate.evaluate(instance: object))
    }
    
}
