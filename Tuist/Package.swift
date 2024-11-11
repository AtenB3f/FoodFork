// swift-tools-version: 6.0
@preconcurrency import PackageDescription

#if TUIST
    import struct ProjectDescription.PackageSettings

    let packageSettings = PackageSettings(
        productTypes: [
            "RxSwift": .framework,
            "SnapKit": .framework,
            "KakaoMapsSDK-SPM": .framework,
            "realm-swift": .framework,
            "SwiftLintPlugins": .framework
        ]
    )
#endif

let package = Package(
    name: "App",
    products: [
        .library(name: "SwiftLint", targets: ["SwiftLint"])
    ],
    dependencies: [
        .package(url: "https://github.com/ReactiveX/RxSwift", .upToNextMajor(from: "6.8.0")),
        .package(url: "https://github.com/SnapKit/SnapKit", .upToNextMajor(from: "5.0.1")),
        .package(url: "https://github.com/kakao-mapsSDK/KakaoMapsSDK-SPM", .upToNextMajor(from: "2.12.0")),
        .package(url: "https://github.com/SimplyDanny/SwiftLintPlugins", .upToNextMajor(from: "0.56.1")),
        .package(url: "https://github.com/realm/realm-swift", .upToNextMajor(from: "10.54.1"))
    ],
    targets: [
        .target(
            name: "SwiftLint",
            plugins: [
                .plugin(name: "SwiftLint", package: "SwiftLintPlugin")
            ]
        )
    ]
)
