// swift-tools-version:5.0
import PackageDescription

let package = Package(
    name: "Saystack",
    platforms: [
        .iOS(.v12)
    ],
    products: [
        .library(name: "Saystack", targets: ["Saystack"]),
    ],
    targets: [
         .target(
            name: "Saystack",
            path: "Code/Extensions",
            exclude: [
                "Code/Supporting Files",
                "Code/Demo"
            ]
         )
    ]
)
