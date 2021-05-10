# Makefile to build Starscream.xcframework

usage:
	@echo "Read the Makefile for targets to run!"

SOURCES = ./Sources/Transport/Transport.swift \
					./Sources/Transport/FoundationTransport.swift \
					./Sources/Transport/TCPTransport.swift \
					./Sources/Security/Security.swift \
					./Sources/Security/FoundationSecurity.swift \
					./Sources/DataBytes/Data+Extensions.swift \
					./Sources/Server/Server.swift \
					./Sources/Server/WebSocketServer.swift \
					./Sources/Framer/FoundationHTTPHandler.swift \
					./Sources/Framer/HTTPHandler.swift \
					./Sources/Framer/FrameCollector.swift \
					./Sources/Framer/StringHTTPHandler.swift \
					./Sources/Framer/FoundationHTTPServerHandler.swift \
					./Sources/Framer/Framer.swift \
					./Sources/Compression/Compression.swift \
					./Sources/Compression/WSCompression.swift \
					./Sources/Starscream/WebSocket.swift \
					./Sources/Engine/Engine.swift \
					./Sources/Engine/NativeEngine.swift \
					./Sources/Engine/WSEngine.swift \
					./Sources/Info.plist

PROJECT = Starscream.xcodeproj

DEPS = Makefile $(PROJECT) $(SOURCES)

archive:	XCFramework/Starscream.xcframework

IOS_TEST_DESTINATION = "platform=iOS Simulator,name=iPhone SE (2nd generation),OS=13.7"
TVOS_TEST_DESTINATION = "platform=tvOS Simulator,name=Apple TV 4K (2nd generation),OS=14.5"
MACOS_TEST_DESTINATION = "platform=macOS,arch=x86_64"

test:
	xcodebuild -project $(PROJECT) -scheme "Starscream" -sdk iphonesimulator -destination $(IOS_TEST_DESTINATION) BUILD_LIBRARY_FOR_DISTRIBUTION=YES SKIP_INSTALL=YES test | xcpretty
	xcodebuild -project $(PROJECT) -scheme "Starscream" -sdk appletvsimulator -destination $(TVOS_TEST_DESTINATION) BUILD_LIBRARY_FOR_DISTRIBUTION=YES SKIP_INSTALL=YES test | xcpretty
	xcodebuild -project $(PROJECT) -scheme "Starscream" -destination $(MACOS_TEST_DESTINATION) BUILD_LIBRARY_FOR_DISTRIBUTION=YES SKIP_INSTALL=YES test | xcpretty

XCFramework/Starscream.xcframework:	.archives/ios_devices.xcarchive \
												.archives/ios_simulator.xcarchive \
												.archives/macos.xcarchive \
												.archives/appletvos.xcarchive \
												.archives/appletvsimulator.xcarchive
	@-rm -rf "$@"
	xcodebuild \
		-create-xcframework \
		-framework .archives/ios_devices.xcarchive/Products/Library/Frameworks/Starscream.framework \
		-framework .archives/ios_simulator.xcarchive/Products/Library/Frameworks/Starscream.framework \
		-framework .archives/macos.xcarchive/Products/Library/Frameworks/Starscream.framework \
		-framework .archives/appletvos.xcarchive/Products/Library/Frameworks/Starscream.framework \
		-framework .archives/appletvsimulator.xcarchive/Products/Library/Frameworks/Starscream.framework \
		-output $@

.archives/ios_devices.xcarchive:	$(DEPS)
	xcodebuild archive -project $(PROJECT) -scheme "Starscream" -sdk iphoneos -archivePath "$@" BUILD_LIBRARY_FOR_DISTRIBUTION=YES SKIP_INSTALL=NO

.archives/ios_simulator.xcarchive:	$(DEPS)
	xcodebuild archive -scheme "Starscream" -sdk iphonesimulator -archivePath "$@" BUILD_LIBRARY_FOR_DISTRIBUTION=YES SKIP_INSTALL=NO

.archives/macos.xcarchive:	$(DEPS)
	xcodebuild archive -scheme "Starscream" -archivePath "$@" BUILD_LIBRARY_FOR_DISTRIBUTION=YES SKIP_INSTALL=NO

.archives/appletvos.xcarchive:	$(DEPS)
	xcodebuild archive -scheme "Starscream" -sdk appletvos -archivePath "$@" BUILD_LIBRARY_FOR_DISTRIBUTION=YES SKIP_INSTALL=NO

.archives/appletvsimulator.xcarchive:	$(DEPS)
	xcodebuild archive -scheme "Starscream" -sdk appletvsimulator -archivePath "$@" BUILD_LIBRARY_FOR_DISTRIBUTION=YES SKIP_INSTALL=NO

