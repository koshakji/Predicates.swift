// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Predicates",
    platforms: [.macOS(.v10_15)],
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "Predicates",
            targets: ["Predicates"]),
        .library(name: "PredicatesNSExtension",
                 targets: ["PredicatesNSExtension"]),
        .library(name: "PredicatesGRDBExtension",
                 targets: ["PredicatesNSExtension"]),
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        // .package(url: /* package url */, from: "1.0.0"),
        .package(url: "https://github.com/groue/GRDB.swift.git", .upToNextMinor(from: "6.5.0")),
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .target(
            name: "Predicates",
            dependencies: []
        ),
        .target(
            name: "PredicatesNSExtension",
            dependencies: ["Predicates"]
        ),
        .target(
            name: "PredicatesGRDBExtension",
            dependencies: [
                "Predicates",
                .product(name: "GRDB", package: "GRDB.swift"),
            ]
        ),
        
        .testTarget(
            name: "PredicatesTests",
            dependencies: ["Predicates"]),
    ]
)
