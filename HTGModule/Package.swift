// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "HTGModule",
    platforms: [.iOS(.v17)],
    products: [
        .library(
            name: "HTGModule",
            targets: ["HTGModule"]
        ),
    ],
    targets: [
        .target(
            name: "HTGModule",
            dependencies: [
                .target(name: "Feature"),
                .target(name: "FeatureInterface"),
                .target(name: "Domain"),
            ],
            path: "Sources/App",
            resources: [.process("Resources")]
        ),
        .target(
            name: "Feature",
            dependencies: [
                .target(name: "FeatureInterface"),
            ],
            path: "Sources/Feature"
        ),
        .target(
            name: "FeatureInterface",
            dependencies: [
                .target(name: "DomainInterface"),
            ],
            path: "Sources/FeatureInterface"
        ),
        .target(
            name: "DomainInterface",
            dependencies: [],
            path: "Sources/DomainInterface"
        ),
        .target(
            name: "Domain",
            dependencies: [
                .target(name: "DomainInterface"),
                .target(name: "DataInterface"),
            ],
            path: "Sources/Domain"
        ),
        .target(
            name: "DataInterface",
            dependencies: [],
            path: "Sources/DataInterface"
        ),
        .target(
            name: "Data",
            dependencies: [
                .target(name: "DataInterface"),
            ],
            path: "Sources/Data"
        ),
        .target(
            name: "Core",
            dependencies: [],
            path: "Sources/Core"
        ),
        .target(
            name: "Shared",
            dependencies: [],
            path: "Sources/Shared"
        )
    ]
)
