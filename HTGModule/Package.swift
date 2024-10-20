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
                .target(name: "FeatureInterface"),
                .target(name: "Feature"),
                .target(name: "DomainInterface"),
                .target(name: "Domain"),
                .target(name: "Core"),
                .target(name: "Shared"),
            ],
            path: "Sources/App",
            resources: [.process("Resources")]
        ),
        .target(
            name: "FeatureInterface",
            dependencies: [
                .target(name: "DomainInterface"),
                .target(name: "Shared"),
            ],
            path: "Sources/FeatureInterface"
        ),
        .target(
            name: "FeatureUI",
            dependencies: [
                .target(name: "FeatureInterface"),
                .target(name: "Shared"),
            ],
            path: "Sources/FeatureUI"
        ),
        .target(
            name: "Feature",
            dependencies: [
                .target(name: "FeatureInterface"),
                .target(name: "FeatureUI"),
                .target(name: "DomainInterface"),
                .target(name: "Domain"),
                .target(name: "Core"),
                .target(name: "Shared"),
            ],
            path: "Sources/Feature"
        ),
        .target(
            name: "DomainInterface",
            dependencies: [
                .target(name: "Shared"),
            ],
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
            dependencies: [
                .target(name: "Shared"),
            ],
            path: "Sources/DataInterface"
        ),
        .target(
            name: "Data",
            dependencies: [
                .target(name: "DataInterface"),
                .target(name: "Shared"),
            ],
            path: "Sources/Data"
        ),
        .target(
            name: "Core",
            dependencies: [
                .target(name: "Shared"),
            ],
            path: "Sources/Core"
        ),
        .target(
            name: "Shared",
            dependencies: [],
            path: "Sources/Shared",
            resources: [.process("Resources")]
        )
    ]
)
