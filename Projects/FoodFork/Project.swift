import ProjectDescription
private let bundleID = "com.AtenB"
private let deploymentTargets:ProjectDescription.DeploymentTargets = .iOS("15.0")
private let name = "FoodFork"
private let infoPlist:[String: Plist.Value] = [
    "KAKAO_APP_KEY":"d8cae7af7226ef488a329b0c06dbf059",
    "UILaunchStoryboardName":"LaunchScreen",
    "CFBundleVersion": "1",
    "UIAppFonts":[
        "NotoSansKR-Bold.otf",
        "NotoSansKR-Regular.otf"
    ],
    "PRODUCT_MODULE_NAME":"\(name)",
    "UIApplicationSceneManifest": [
        "UISceneConfigurations":[
            "UIWindowSceneSessionRoleApplication": [
                [
                    "UISceneConfigurationName": "Default Configuration",
                    "UISceneDelegateClassName": "$(PRODUCT_MODULE_NAME).SceneDelegate"
                ],
            ]
        ]
    ],
    "NSPhotoLibraryUsageDescription": "앨범 접근 권한 동의",
    "NSCameraUsageDescription":"카메라 접근 권한 동의"
]
private let dependencies: [TargetDependency]  = [
    .package(product: "RxSwift"),
    .package(product: "RxCocoa"),
    .package(product: "SnapKit"),
    .package(product: "KakaoMapsSDK-SPM"),
    .project(target: "Data", path: .relativeToRoot("Projects/Data")),
    .project(target: "Design", path: .relativeToRoot("Projects/Design")),
    .project(target: "Domain", path: .relativeToRoot("Projects/Domain")),
    .project(target: "Utility", path: .relativeToRoot("Projects/Utility")),
]
private let packages: [Package] = [
    .package(url: "https://github.com/ReactiveX/RxSwift", .upToNextMajor(from: "6.8.0")),
    .package(url: "https://github.com/SnapKit/SnapKit", .upToNextMajor(from: "5.0.1")),
    .package(url: "https://github.com/kakao-mapsSDK/KakaoMapsSDK-SPM", .upToNextMajor(from: "2.0.0")),
    .package(url: "https://github.com/SimplyDanny/SwiftLintPlugins", .upToNextMajor(from: "0.56.1")),
//    .package(url: "https://github.com/realm/realm-swift", .upToNextMajor(from: "10.54.1")),
]

let project =  Project(
    name: name,
    packages: packages,
    targets: [
    .target(
        name: name,
        destinations: .iOS,
        product: .app,
        bundleId: bundleID + ".\(name)",
        deploymentTargets: deploymentTargets,
        infoPlist: .extendingDefault(with:infoPlist),
        sources: ["Sources/**"],
        resources: ["Resources/**"],
        dependencies: dependencies
    ),
    .target(
        name: "\(name)Tests",
        destinations: .iOS,
        product: .uiTests,
        bundleId: bundleID + ".\(name)" + "Tests",
        deploymentTargets: deploymentTargets,
        infoPlist: .default,
        sources: ["Tests/**"],
        resources: [],
        dependencies: [.target(name: name)]
    )
    ],
    schemes: []
)
