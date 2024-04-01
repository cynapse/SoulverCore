// swift-tools-version:5.7

import PackageDescription

let package = Package(
    name: "SoulverCore",
    products: [
        .library(
            name: "SoulverCore",
            targets: ["SoulverCore"]),
    ],
    targets: [
        .binaryTarget(
            name: "SoulverCore",
            url: "https://github.com/cynapse/SoulverCore/releases/download/2.6.2/SoulverCore.xcframework.zip",
            checksum: "a03e251333210f7cdea7016df280204983334a5f2d4df656f32be21b7f10e196"),
    ]
)
