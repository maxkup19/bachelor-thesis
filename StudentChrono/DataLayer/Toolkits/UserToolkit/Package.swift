// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "UserToolkit",
    platforms: [.iOS(.v17)],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "UserToolkit",
            targets: ["UserToolkit"]),
    ],
    dependencies: [
        .package(name: "Utilities", path: "../../../DomainLayer/Utilities"),
        .package(name: "SharedDomain", path: "../../../DomainLayer/SharedDomain"),
        .package(name: "NetworkProvider", path: "../../Providers/NetworkProvider"),
        .package(url: "https://github.com/firebase/firebase-ios-sdk.git", .upToNextMajor(from: "10.25.0"))
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "UserToolkit",
            dependencies: [
                .product(name: "Utilities", package: "Utilities"),
                .product(name: "SharedDomain", package: "SharedDomain"),
                .product(name: "NetworkProvider", package: "NetworkProvider"),
                .product(name: "FirebaseStorage", package: "firebase-ios-sdk")
            ]
        ),
        .testTarget(
            name: "UserToolkitTests",
            dependencies: [
                "UserToolkit",
                .product(name: "Utilities", package: "Utilities"),
                .product(name: "SharedDomain", package: "SharedDomain"),
                .product(name: "SharedDomainMocks", package: "SharedDomain"),
                .product(name: "NetworkProvider", package: "NetworkProvider"),
                .product(name: "NetworkProviderMocks", package: "NetworkProvider")
            ]
        ),
    ]
)
