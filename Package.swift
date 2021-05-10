// swift-tools-version:5.2

//
//  Package.Swift
//  Starscream
//
//  Created by Dalton Cherry on 5/16/15.
//  Copyright (c) 2014-2016 Dalton Cherry.
//
//  Licensed under the Apache License, Version 2.0 (the "License");
//  you may not use this file except in compliance with the License.
//  You may obtain a copy of the License at
//
//  http://www.apache.org/licenses/LICENSE-2.0
//
//  Unless required by applicable law or agreed to in writing, software
//  distributed under the License is distributed on an "AS IS" BASIS,
//  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//  See the License for the specific language governing permissions and
//  limitations under the License.
//

import PackageDescription

let package = Package(
	name: "Starscream",
	platforms: [ .macOS(.v10_10), .iOS(.v12), .tvOS(.v12) ],
	products: [ .library(name: "Starscream", targets: [ "Starscream" ]) ],
	targets: [ 
#if os(Linux)
		.target(name: "Starscream", path: "Sources")
#else
		.binaryTarget(name: "Starscream", path: "XCFramework/Starscream.xcframework") 
#endif
	]
	dependencies: [
	]
)

#if os(Linux)
    package.dependencies.append(.package(url: "https://github.com/apple/swift-nio-zlib-support.git", from: "1.0.0"))
#endif
