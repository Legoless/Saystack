// swift-tools-version:6.0
import PackageDescription

let package = Package(
    name: "Saystack",
    platforms: [
        .iOS(.v15)
    ],
    products: [
        .library(name: "Saystack", targets: ["Saystack"]),
    ],
    targets: [
         .target(
            name: "Saystack",
            path: "Code/Extensions",
            swiftSettings: [
                .swiftLanguageMode(.v6)
            ]
         )
    ]
)
