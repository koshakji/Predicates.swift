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
    
    func testREADME() throws {
        struct Person: Equatable {
            let name: String
            var age: Int
            var isDead: Bool
        }
        
        let majd = Person(name: "Majd", age: 24, isDead: false)
        let nidal = Person(name: "Nidal", age: 16, isDead: false)
        let john = Person(name: "John", age: 70, isDead: false)
        let thaer = Person(name: "Thaer", age: 17, isDead: true)
        
        let people = [
            majd,
            nidal,
            john,
            thaer,
        ]
        
        let adultPredicate = \Person.age >= 18
        XCTAssertTrue(adultPredicate.evaluate(majd))
        XCTAssertFalse(adultPredicate.evaluate(nidal))
        XCTAssertTrue(adultPredicate.evaluate(john))
        XCTAssertFalse(adultPredicate.evaluate(thaer))
        
        XCTAssertEqual(people.filter(adultPredicate), [majd, john])

        let eligibleForFreeMedicationPredicate = (\Person.age < 18 || \Person.age > 65) && !\Person.isDead
        XCTAssertEqual(people.filter(eligibleForFreeMedicationPredicate), [nidal, john])
    }
    
    func testEquality() throws {
        let trueIntegerPredicate = \Something.integer == 1
        let trueStringPredicate = \Something.string == "hello world"
        let trueArrayPredicate = \Something.array == [1,4,6]
        let trueNestedIntegerPredicate = \Something.nested.nestedInteger == 8
        let trueObjectPredicate = \Something.nested == NestedThing(nestedInteger: 8)
        
        XCTAssertTrue(trueIntegerPredicate.evaluate(object))
        XCTAssertTrue(trueStringPredicate.evaluate(object))
        XCTAssertTrue(trueArrayPredicate.evaluate(object))
        XCTAssertTrue(trueNestedIntegerPredicate.evaluate(object))
        XCTAssertTrue(trueObjectPredicate.evaluate(object))
        
        let falseIntegerPredicate = \Something.integer == 2
        let falseStringPredicate = \Something.string == "hello"
        let falseArrayPredicate = \Something.array == [1,4,8]
        let falseNestedIntegerPredicate = \Something.nested.nestedInteger == 5
        let falseObjectPredicate = \Something.nested == NestedThing(nestedInteger: 5)
        
        
        XCTAssertFalse(falseIntegerPredicate.evaluate(object))
        XCTAssertFalse(falseStringPredicate.evaluate(object))
        XCTAssertFalse(falseArrayPredicate.evaluate(object))
        XCTAssertFalse(falseNestedIntegerPredicate.evaluate(object))
        XCTAssertFalse(falseObjectPredicate.evaluate(object))
    }
    
    func testGreaterThan() throws {
        let trueIntegerPredicate = \Something.integer > 0
        let trueStringPredicate = \Something.string > "gello world"
        let trueNestedIntegerPredicate = \Something.nested.nestedInteger > 5
        let trueObjectPredicate = \Something.nested > NestedThing(nestedInteger: 5)
        
        XCTAssertTrue(trueIntegerPredicate.evaluate(object))
        XCTAssertTrue(trueStringPredicate.evaluate(object))
        XCTAssertTrue(trueNestedIntegerPredicate.evaluate(object))
        XCTAssertTrue(trueObjectPredicate.evaluate(object))
        
        let falseIntegerPredicate = \Something.integer > 2
        let falseStringPredicate = \Something.string > "iello"
        let falseNestedIntegerPredicate = \Something.nested.nestedInteger > 10
        let falseObjectPredicate = \Something.nested > NestedThing(nestedInteger: 10)
        
        XCTAssertFalse(falseIntegerPredicate.evaluate(object))
        XCTAssertFalse(falseStringPredicate.evaluate(object))
        XCTAssertFalse(falseNestedIntegerPredicate.evaluate(object))
        XCTAssertFalse(falseObjectPredicate.evaluate(object))
    }
    
    func testLessThan() throws {
        let trueIntegerPredicate = \Something.integer < 2
        let trueStringPredicate = \Something.string < "iello"
        let trueNestedIntegerPredicate = \Something.nested.nestedInteger < 10
        let trueObjectPredicate = \Something.nested < NestedThing(nestedInteger: 10)
        
        XCTAssertTrue(trueIntegerPredicate.evaluate(object))
        XCTAssertTrue(trueStringPredicate.evaluate(object))
        XCTAssertTrue(trueNestedIntegerPredicate.evaluate(object))
        XCTAssertTrue(trueObjectPredicate.evaluate(object))
        
        let falseIntegerPredicate = \Something.integer < 0
        let falseStringPredicate = \Something.string < "gello"
        let falseNestedIntegerPredicate = \Something.nested.nestedInteger < 5
        let falseObjectPredicate = \Something.nested < NestedThing(nestedInteger: 5)
        
        XCTAssertFalse(falseIntegerPredicate.evaluate(object))
        XCTAssertFalse(falseStringPredicate.evaluate(object))
        XCTAssertFalse(falseNestedIntegerPredicate.evaluate(object))
        XCTAssertFalse(falseObjectPredicate.evaluate(object))
    }
    
    func testGreaterThanOrEqual() throws {
        var trueIntegerPredicate = \Something.integer >= 0
        var trueStringPredicate = \Something.string >= "gello world"
        var trueNestedIntegerPredicate = \Something.nested.nestedInteger >= 5
        var trueObjectPredicate = \Something.nested >= NestedThing(nestedInteger: 5)
        
        XCTAssertTrue(trueIntegerPredicate.evaluate(object))
        XCTAssertTrue(trueStringPredicate.evaluate(object))
        XCTAssertTrue(trueNestedIntegerPredicate.evaluate(object))
        XCTAssertTrue(trueObjectPredicate.evaluate(object))
        
        trueIntegerPredicate = \Something.integer >= 1
        trueStringPredicate = \Something.string >= "hello world"
        trueNestedIntegerPredicate = \Something.nested.nestedInteger >= 8
        trueObjectPredicate = \Something.nested >= NestedThing(nestedInteger: 8)
        
        XCTAssertTrue(trueIntegerPredicate.evaluate(object))
        XCTAssertTrue(trueStringPredicate.evaluate(object))
        XCTAssertTrue(trueNestedIntegerPredicate.evaluate(object))
        XCTAssertTrue(trueObjectPredicate.evaluate(object))
        
        let falseIntegerPredicate = \Something.integer >= 2
        let falseStringPredicate = \Something.string >= "iello"
        let falseNestedIntegerPredicate = \Something.nested.nestedInteger >= 10
        let falseObjectPredicate = \Something.nested >= NestedThing(nestedInteger: 10)
        
        XCTAssertFalse(falseIntegerPredicate.evaluate(object))
        XCTAssertFalse(falseStringPredicate.evaluate(object))
        XCTAssertFalse(falseNestedIntegerPredicate.evaluate(object))
        XCTAssertFalse(falseObjectPredicate.evaluate(object))
    }
    
    func testLessThanOrEqual() throws {
        var trueIntegerPredicate = \Something.integer <= 2
        var trueStringPredicate = \Something.string <= "iello"
        var trueNestedIntegerPredicate = \Something.nested.nestedInteger <= 10
        var trueObjectPredicate = \Something.nested <= NestedThing(nestedInteger: 10)
        
        XCTAssertTrue(trueIntegerPredicate.evaluate(object))
        XCTAssertTrue(trueStringPredicate.evaluate(object))
        XCTAssertTrue(trueNestedIntegerPredicate.evaluate(object))
        XCTAssertTrue(trueObjectPredicate.evaluate(object))
        
        trueIntegerPredicate = \Something.integer <= 1
        trueStringPredicate = \Something.string <= "hello world"
        trueNestedIntegerPredicate = \Something.nested.nestedInteger <= 8
        trueObjectPredicate = \Something.nested <= NestedThing(nestedInteger: 8)
        
        XCTAssertTrue(trueIntegerPredicate.evaluate(object))
        XCTAssertTrue(trueStringPredicate.evaluate(object))
        XCTAssertTrue(trueNestedIntegerPredicate.evaluate(object))
        XCTAssertTrue(trueObjectPredicate.evaluate(object))
        
        let falseIntegerPredicate = \Something.integer <= 0
        let falseStringPredicate = \Something.string <= "gello"
        let falseNestedIntegerPredicate = \Something.nested.nestedInteger <= 5
        let falseObjectPredicate = \Something.nested <= NestedThing(nestedInteger: 5)
        
        XCTAssertFalse(falseIntegerPredicate.evaluate(object))
        XCTAssertFalse(falseStringPredicate.evaluate(object))
        XCTAssertFalse(falseNestedIntegerPredicate.evaluate(object))
        XCTAssertFalse(falseObjectPredicate.evaluate(object))
    }
    
}
