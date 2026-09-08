// swift-tools-version: 6.4
import PackageDescription

let package = Package(
    name: "swift-translation",
    platforms: [.macOS(.v27), .iOS(.v27), .tvOS(.v27), .watchOS(.v27), .visionOS(.v27)],
    products: [.library(name: "Translation", targets: ["Translation"])],
    dependencies: [
        .package(url: "https://github.com/swift-atoms/swift-displacement.git", branch: "main"),
        .package(url: "https://github.com/swift-atoms/swift-vector.git", branch: "main"),
    ],
    targets: [
        .target(name: "Translation", dependencies: [

        ]),
        .testTarget(name: "Translation Tests", dependencies: [
            .target(name: "Translation"),
            .product(name: "Displacement", package: "swift-displacement"),
            .product(name: "Vector", package: "swift-vector"),
        ]),
    ],
    swiftLanguageModes: [.v6]
)

for target in package.targets {
    target.swiftSettings = [
        .strictMemorySafety(),
        .enableUpcomingFeature("ExistentialAny"),
        .enableUpcomingFeature("InternalImportsByDefault"),
        .enableUpcomingFeature("MemberImportVisibility"),
        .enableUpcomingFeature("NonisolatedNonsendingByDefault"),
        .enableExperimentalFeature("Lifetimes"),
        .enableUpcomingFeature("InferIsolatedConformances"),
    ]
}
