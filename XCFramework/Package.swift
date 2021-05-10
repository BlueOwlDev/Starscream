// swift-tools-version:5.3

import PackageDescription

let package = Package(
    name: "Starscream",
    platforms: [ 
			.macOS(.v10_10), .iOS(.v12), .tvOS(.v12)
		],
		products: [ 
			.library(name: "Starscream", targets: [ "Starscream" ]) 
		],
		targets: [ 
			.binaryTarget(name: "Starscream", path: "Starscream.xcframework") 
		]
)
