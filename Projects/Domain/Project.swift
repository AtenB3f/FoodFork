import ProjectDescription

private let bundleID = "com.AtenB"
private let deploymentTargetsData:ProjectDescription.DeploymentTargets = .iOS("15.0")
private let name = "Domain"
private let infoPlist:[String: Plist.Value] = [:]
private let dependencies: [TargetDependency]  = []
private let packages: [Package] = [
]


let domainProject =  Project(
    name: name,
    packages: packages,
    targets: [
    .target(
        name: name,
        destinations: .iOS,
        product: .framework,
        bundleId: bundleID + ".\(name)",
        deploymentTargets: deploymentTargetsData,
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
        deploymentTargets: deploymentTargetsData,
        infoPlist: .default,
        sources: ["Tests/**"],
        resources: [],
        dependencies: [.target(name: name)]
    )
    ],
    schemes: []
)
