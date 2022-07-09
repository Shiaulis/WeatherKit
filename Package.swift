// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "WeatherKit",
    platforms: [
        .iOS("16.0"),
        .macOS("12.0"),
    ],
    products: [
        .library(
            name: "WeatherKit",
            targets: ["WeatherKit"]),
    ],
    dependencies: [
        .package(
            url: "https://github.com/drmohundro/SWXMLHash",
            from: "7.0.0"
        ),
    ],
    targets: [
        .target(
            name: "WeatherKit",
            dependencies: ["SWXMLHash"]
        ),
        .testTarget(
            name: "WeatherKitTests",
            dependencies: ["WeatherKit"],
            resources: [
                .process("TestForecast.xml"),
            ]
        ),

    ]
)
