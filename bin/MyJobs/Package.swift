// swift-tools-version: 5.6
import PackageDescription

let package = Package(
    name: "MyJobs",
    platforms: [.macOS(.v12)],
    products: [
        .executable(
            name: "MyJobs",
            targets: ["MyJobs"]),
    ],
    dependencies: [
        .package(url: "https://github.com/davepaul0/SwiftJobs.git", from: "0.2.0")
    ],
    targets: [
        .executableTarget(
            name: "MyJobs",
            dependencies: [.product(name: "SwiftJobs", package: "SwiftJobs")]),
    ]
)
