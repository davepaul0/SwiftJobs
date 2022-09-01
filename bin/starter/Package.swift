// swift-tools-version: 5.7
import PackageDescription

let package = Package(
    name: "MyJobs",
    platforms: [.macOS(.v13)],
    products: [
        .executable(
            name: "MyJobs",
            targets: ["MyJobs"]),
    ],
    dependencies: [
        .package(url: "https://github.com/davepaul0/SwiftJobs.git", from: "0.1.0")
    ],
    targets: [
        .executableTarget(
            name: "MyJobs",
            dependencies: [.product(name: "JobsKit", package: "SwiftJobs")]),
    ]
)