// swift-tools-version:3.1

import PackageDescription

let package = Package(
    name: "InputEvents",
    dependencies: [
        .Package(url: "https://github.com/Dev1an/CLinuxInput.git",  majorVersion: 1)
    ]
)
