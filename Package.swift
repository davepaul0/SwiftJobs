// swift-tools-version: 5.6
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "SwiftJobs",
    platforms: [.macOS(.v12)],
    products: [
        .library(name: "JobsKit", targets: ["JobsKit"])
    ],
    dependencies: [

    ],
    targets: [
        .target(
            name: "JobsKit",
            dependencies: []),
    ]
)
