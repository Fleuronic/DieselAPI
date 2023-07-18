// swift-tools-version:5.6
import PackageDescription

let package = Package(
    name: "DieselAPI",
	platforms: [
		.iOS(.v13),
		.macOS(.v10_15),
		.tvOS(.v13),
		.watchOS(.v6)
	],
    products: [
        .library(
            name: "DieselAPI",
            targets: ["DieselAPI"]
		)
    ],
	dependencies: [
		.package(url: "https://github.com/Fleuronic/DieselService", branch: "main"),
		.package(url: "https://github.com/Fleuronic/Caesura", branch: "main")
	],
    targets: [
        .target(
            name: "DieselAPI",
            dependencies: [
				"DieselService",
				"Caesura"
			]
		)
    ]
)
