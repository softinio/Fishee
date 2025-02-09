// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
  name: "Fishee",
  products: [
    .executable(name: "fishee", targets: ["Fishee"])
  ],
  dependencies: [
    .package(
      url: "https://github.com/apple/swift-argument-parser.git", .upToNextMajor(from: "1.5.0"))
  ],
  targets: [
    .executableTarget(
      name: "Fishee",
      dependencies: [
        .product(name: "ArgumentParser", package: "swift-argument-parser")
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
        .process("TestPlan.xctestplan"),
      ]
    ),
  ]
)
