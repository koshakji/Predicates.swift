# Predicates.swift

Predicates.swift is a Swift package that aims to create predicates that can filter Swift objects in a type-safe manner based on `KeyPath`s.

The goal is to also provide converters to popular filtering tools like `NSPredicate` and SQL when possible.

## Example Usage
Given the following sample struct and data:

```swift
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
```

You can build a predicate for a specific type by simply comparing a particular keyPath to some value:

```swift
let adultPredicate = \Person.age > 18
```

And then you can use that predicate to evaluate a single person:

```swift
adultPredicate.evaluate(majd) // true
adultPredicate.evaluate(nidal) // false
``` 

Or filter the array:

```swift
people.filter(adultPredicate) // [majd, john]
```

You can also create more complicated predicates using the regular `&&`, `||`, and `!` operators:

```swift
let eligibleForFreeMedicationPredicate = (\Person.age < 18 || \Person.age > 65) && !\Person.isDead
people.filter(eligibleForFreeMedicationPredicate) // [nidal, john]
``` 
