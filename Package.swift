// swift-tools-version:5.0
import PackageDescription

let package = Package(
    name: "BlubBlubCore",
    products: [
        .library(name: "Saystack", targets: ["Saystack"]),
    ],
    targets: [
         .target(
            name: "Saystack",
            exclude: [
                "Code/Supporting Files",
                "Code/Demo"
            ]
         )
    ]
)
