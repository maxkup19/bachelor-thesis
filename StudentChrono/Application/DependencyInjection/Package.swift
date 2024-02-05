// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "DependencyInjection",
    platforms: [.iOS(.v17)],
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "DependencyInjection",
            targets: ["DependencyInjection"]
        )
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        // .package(url: /* package url */, from: "1.0.0"),
        
        .package(url: "https://github.com/hmlongco/Factory.git", .upToNextMajor(from: "2.3.0")),
        .package(name: "Utilities", path: "../../DomainLayer/Utilities"),
        
        // Providers
        .package(name: "KeychainProvider", path: "../../DataLayer/Providers/KeychainProvider"),
        .package(name: "UserDefaultsProvider", path: "../../DataLayer/Providers/UserDefaultsProvider")
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .target(
            name: "DependencyInjection",
            dependencies: [
                .product(name: "Factory", package: "Factory"),
                .product(name: "Utilities", package: "Utilities"),
                
                // Providers
                .product(name: "KeychainProvider", package: "KeychainProvider"),
                .product(name: "UserDefaultsProvider", package: "UserDefaultsProvider")
            ]
        )
    ]
)
