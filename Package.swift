// swift-tools-version: 5.6
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "SwiftJobs",
    platforms: [.macOS(.v12)],
    products: [
        .library(name: "SwiftJobs", targets: ["SwiftJobs"])
    ],
    dependencies: [

    ],
    targets: [
        .target(
            name: "SwiftJobs",
            dependencies: []),
        .testTarget(name: "SwiftJobsTests",
                   dependencies: ["SwiftJobs"])
    ]
)
