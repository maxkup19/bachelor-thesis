// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "NetworkProvider",
    platforms: [.iOS(.v17)],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "NetworkProvider",
            targets: ["NetworkProvider"]
        ),
        .library(
            name: "NetworkProviderMocks",
            targets: ["NetworkProviderMocks"]
        )
    ],
    dependencies: [
        .package(name: "SharedDomain", path: "../../../DomainLayer/SharedDomain")
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "NetworkProvider",
            dependencies: [
                .product(name: "SharedDomain", package: "SharedDomain")
            ]
        ),
        .target(
            name: "NetworkProviderMocks",
            dependencies: [
                "NetworkProvider"
            ]
        )
    ]
)
