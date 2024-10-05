// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Fishee",
    dependencies:  [
        .package(url: "https://github.com/apple/swift-argument-parser.git", .upToNextMajor(from: "1.5.0")),
        .package(url: "https://github.com/duckdb/duckdb-swift", .upToNextMinor(from: .init(1, 1, 0))),
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .executableTarget(
            name: "Fishee",
            dependencies: [
                .product(name: "ArgumentParser", package: "swift-argument-parser"),
                .product(name: "DuckDB", package: "duckdb-swift"),
            ],
            path: "Sources"
        ),
        .testTarget(
            name: "FisheeTests",
            dependencies: ["Fishee"],
            path: "Tests",
            resources: [
                .copy("Resources/fish_history_test.txt"),
                .copy("Resources/fish_history_test_2.txt"),
            ]
        )
    ]
)
