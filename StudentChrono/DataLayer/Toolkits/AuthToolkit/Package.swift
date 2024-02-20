// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "AuthToolkit",
    platforms: [.iOS(.v17)],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "AuthToolkit",
            targets: ["AuthToolkit"]),
    ],
    dependencies: [
        .package(name: "Utilities", path: "../../../DomainLayer/Utilities"),
        .package(name: "SharedDomain", path: "../../../DomainLayer/SharedDomain"),
        .package(name: "KeychainProvider", path: "../../Providers/KeychainProvider"),
        .package(name: "NetworkProvider", path: "../../Providers/NetworkProvider")
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "AuthToolkit",
            dependencies: [
                .product(name: "Utilities", package: "Utilities"),
                .product(name: "SharedDomain", package: "SharedDomain"),
                .product(name: "KeychainProvider", package: "KeychainProvider"),
                .product(name: "NetworkProvider", package: "NetworkProvider")
            ]
        ),
        .testTarget(
            name: "AuthToolkitTests",
            dependencies: [
                "AuthToolkit",
                .product(name: "Utilities", package: "Utilities"),
                .product(name: "SharedDomain", package: "SharedDomain"),
                .product(name: "SharedDomainMocks", package: "SharedDomain"),
                .product(name: "KeychainProvider", package: "KeychainProvider"),
                .product(name: "KeychainProviderMocks", package: "KeychainProvider"),
                .product(name: "NetworkProvider", package: "NetworkProvider"),
                .product(name: "NetworkProviderMocks", package: "NetworkProvider")
            ]
        )
    ]
)
