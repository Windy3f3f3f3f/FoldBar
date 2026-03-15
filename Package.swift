// swift-tools-version: 5.7
import PackageDescription

let package = Package(
    name: "FoldBar",
    platforms: [.macOS(.v12)],
    targets: [
        .executableTarget(
            name: "FoldBar",
            path: "Sources/FoldBar"
        )
    ]
)
