// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "StudentsToolkit",
    platforms: [.iOS(.v17)],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "StudentsToolkit",
            targets: ["StudentsToolkit"]),
    ],
    dependencies: [
        .package(name: "Utilities", path: "../../../DomainLayer/Utilities"),
        .package(name: "SharedDomain", path: "../../../DomainLayer/SharedDomain"),
        .package(name: "NetworkProvider", path: "../../Providers/NetworkProvider"),
        .package(name: "UserToolkit", path: "../UserToolkit")
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "StudentsToolkit",
            dependencies: [
                .product(name: "Utilities", package: "Utilities"),
                .product(name: "SharedDomain", package: "SharedDomain"),
                .product(name: "NetworkProvider", package: "NetworkProvider"),
                .product(name: "UserToolkit", package: "UserToolkit")
            ]
        ),
        .testTarget(
            name: "StudentsToolkitTests",
            dependencies: [
                "StudentsToolkit",
                .product(name: "Utilities", package: "Utilities"),
                .product(name: "SharedDomain", package: "SharedDomain"),
                .product(name: "SharedDomainMocks", package: "SharedDomain"),
                .product(name: "NetworkProvider", package: "NetworkProvider"),
                .product(name: "NetworkProviderMocks", package: "NetworkProvider"),
            ]
        )
    ]
)

