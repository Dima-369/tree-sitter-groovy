// swift-tools-version:5.3

import Foundation
import PackageDescription

var sources = ["src/parser.c"]
if FileManager.default.fileExists(atPath: "src/scanner.c") {
    sources.append("src/scanner.c")
}

let package = Package(
    name: "TreeSitterGroovy",
    products: [
        .library(name: "TreeSitterGroovy", targets: ["TreeSitterGroovy"]),
    ],
    dependencies: [
        .package(url: "https://github.com/ChimeHQ/SwiftTreeSitter", from: "0.8.0"),
    ],
    targets: [
        .target(
            name: "TreeSitterGroovy",
            dependencies: [],
            path: ".",
            sources: sources,
            resources: [
                .copy("queries")
            ],
            publicHeadersPath: "bindings/swift",
            cSettings: [.headerSearchPath("src")]
        ),
        .testTarget(
            name: "TreeSitterGroovyTests",
            dependencies: [
                "SwiftTreeSitter",
                "TreeSitterGroovy",
            ],
            path: "bindings/swift/TreeSitterGroovyTests"
        )
    ],
    cLanguageStandard: .c11
)
