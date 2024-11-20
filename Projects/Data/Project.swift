import ProjectDescription

private let bundleID = "com.AtenB"
private let deploymentTargets:ProjectDescription.DeploymentTargets = .iOS("15.0")
private let name = "Data"
private let infoPlist:[String: Plist.Value] = [:]
private let dependencies: [TargetDependency]  = [
    .package(product: "RxSwift"),
    .package(product: "RxCocoa"),
    .package(product: "KakaoMapsSDK-SPM"),
    .external(name: "Realm"),
    .external(name: "RealmSwift")
//    .package(product: "Realm"),
//    .package(product: "RealmSwift"),
]
private let packages: [Package] = [
    .package(url: "https://github.com/kakao-mapsSDK/KakaoMapsSDK-SPM", .upToNextMajor(from: "2.0.0"))
//    .remote(url: "https://github.com/realm/realm-swift", requirement: .upToNextMajor(from: "10.54.1"))
]

let dataProject = Project(
    name: name,
    packages: packages,
    targets: [
    .target(
        name: name,
        destinations: .iOS,
        product: .framework,
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
