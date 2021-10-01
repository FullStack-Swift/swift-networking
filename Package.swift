  // swift-tools-version:5.5
  // The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
  name: "Networking",
  platforms: [
    .iOS(.v10),
    .macOS(.v10_12),
    .tvOS(.v10),
    .watchOS(.v3)
  ],
  products: [
    // request
    .library(
      name: "CombineRequest",
      targets: ["SwiftRequest", "CombineRequest"]),
    .library(
      name: "RxSwiftRequest",
      targets: ["SwiftRequest", "RxSwiftRequest"]),
    .library(
      name: "ReactiveSwiftRequest",
      targets: ["SwiftRequest", "ReactiveSwiftRequest"]),
    // websocket
    .library(
      name: "CombineWebSocket",
      targets: ["SwiftWebSocket","CombineWebSocket"]),
    .library(
      name: "RxSwiftWebSocket",
      targets: ["SwiftWebSocket","RxSwiftWebSocket"]),
    .library(
      name: "ReactiveSwiftWebSocket",
      targets: ["SwiftWebSocket","ReactiveSwiftWebSocket"]),
  ],
  dependencies: [
    .package(url: "https://github.com/Alamofire/Alamofire.git", from: "5.5.0"),
    .package(url: "https://github.com/daltoniam/Starscream.git", from: "4.0.4"),
    .package(url: "https://github.com/ReactiveX/RxSwift.git", from: "6.5.0"),
    .package(url: "https://github.com/ReactiveCocoa/ReactiveSwift.git", from: "7.0.0"),
  ],
  targets: [
    //build request
    .target(name: "BuildRequest", dependencies: ["Alamofire"]),
    //request
    .target(
      name: "SwiftRequest",
      dependencies: ["BuildRequest"],
      path: "Sources/MRequest/SwiftRequest"
    ),
    .target(name: "CombineRequest",
            dependencies: ["SwiftRequest"],
            path: "Sources/MRequest/CombineRequest"
           ),
    .target(name: "RxSwiftRequest",
            dependencies: ["SwiftRequest", "RxSwift"],
            path: "Sources/MRequest/RxSwiftRequest"
           ),
    .target(name: "ReactiveSwiftRequest",
            dependencies: ["SwiftRequest", "ReactiveSwift"],
            path: "Sources/MRequest/ReactiveSwiftRequest"
           ),
    .testTarget(
      name: "AnyRequestTests",
      dependencies: ["SwiftRequest", "CombineRequest", "RxSwiftRequest", "ReactiveSwiftRequest"]
    ),
    // websocket
    .target(
      name: "SwiftWebSocket",
      dependencies: ["Starscream", "BuildRequest"],
      path: "Sources/MSocket/SwiftWebSocket"
    ),
    .target(
      name: "CombineWebSocket",
      dependencies: ["SwiftWebSocket"],
      path: "Sources/MSocket/CombineWebSocket"
    ),
    .target(
      name: "RxSwiftWebSocket",
      dependencies: ["SwiftWebSocket", "RxSwift"],
      path: "Sources/MSocket/RxSwiftWebSocket"
    ),
    .target(
      name: "ReactiveSwiftWebSocket",
      dependencies: ["SwiftWebSocket", "ReactiveSwift"],
      path: "Sources/MSocket/ReactiveSwiftWebSocket"
    ),
  ]
)
