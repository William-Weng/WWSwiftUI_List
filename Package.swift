// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "WWSwiftUI_List",
    platforms: [
        .iOS(.v16)
    ],
    products: [
        .library(name: "WWSwiftUI_List", targets: ["WWSwiftUI_List"]),
    ],
    dependencies: [
        .package(url: "https://github.com/William-Weng/WWSwiftUI_MultiDatePicker", from: "1.2.3")
    ],
    targets: [
        .target(name: "WWSwiftUI_List", dependencies: ["WWSwiftUI_MultiDatePicker"], resources: [.copy("Privacy")]),
    ],
    swiftLanguageVersions: [
        .v5
    ]
)
