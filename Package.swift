// swift-tools-version:4.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "EasyJWT",
    products: [
        // Products define the executables and libraries produced by a package, and make them visible to other packages.
        .library(
            name: "EasyJWT",
            targets: ["EasyJWT"]),
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        // .package(url: /* package url */, from: "1.0.0"),
    .package(url: "https://github.com/krzyzanowskim/CryptoSwift", from: "0.6.9"),
    .package(url: "https://gitlab.com/katalysis/RSAKey", from: "0.1.0"),
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages which this package depends on.
        .target(
            name: "EasyJWT",
            dependencies: ["CryptoSwift", "RSAKey"]),
        .testTarget(
            name: "EasyJWTTests",
            dependencies: ["EasyJWT","CryptoSwift", "RSAKey"]),
    ]
)
