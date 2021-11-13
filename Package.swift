// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "WeatherKit",
    platforms: [
        .iOS("15.0"),
        .macOS(.v11),
    ],
    products: [
        .library(
            name: "WeatherKit",
            targets: ["WeatherKit"]),
    ],
    dependencies: [
        .package(
            url: "https://github.com/drmohundro/SWXMLHash",
            from: "5.0.0"
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
