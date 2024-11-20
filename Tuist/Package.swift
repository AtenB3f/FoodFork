// swift-tools-version: 6.0
@preconcurrency import PackageDescription

#if TUIST
    import struct ProjectDescription.PackageSettings

    let packageSettings = PackageSettings(
        productTypes: [
            "KakaoMapsSDK-SPM": .framework,
        ]
    )
#endif

let package = Package(
    name: "Package",
    products: [
//        .plugin(name: "SwiftLintPlugins", targets: ["FoodFork"])
//        .library(name: "SwiftLintPlugin", targets: ["FoodFork"])
    ],
    dependencies: [
        .package(url: "https://github.com/kakao-mapsSDK/KakaoMapsSDK-SPM", .upToNextMajor(from: "2.0.0")),
//        .package(url: "https://github.com/SimplyDanny/SwiftLintPlugins", .upToNextMajor(from: "0.56.1")),
    ],
    targets: [
//        .target(
//            name: "FoodFork",
//            plugins: [
//                .plugin(name: "SwiftLintPlugins", package: "SwiftLintPlugins")
//            ]
//        ),
    ]
)

