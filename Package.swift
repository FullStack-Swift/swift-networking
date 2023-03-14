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
      targets: ["MRequest", "MCombineRequest"]),
    .library(
      name: "RxSwiftRequest",
      targets: ["MRequest", "MRxSwiftRequest"]),
    .library(
      name: "ReactiveSwiftRequest",
      targets: ["MRequest", "MReactiveSwiftRequest"]),
    // websocket
    .library(
      name: "CombineWebSocket",
      targets: ["MWebSocket","MCombineWebSocket"]),
    .library(
      name: "RxSwiftWebSocket",
      targets: ["MWebSocket","MRxSwiftWebSocket"]),
    .library(
      name: "ReactiveSwiftWebSocket",
      targets: ["MWebSocket","MReactiveSwiftWebSocket"]),
    // socketio
    .library(
      name: "CombineSocketIO",
      targets: ["MSocketIO", "MCombineSocketIO"]),
    .library(
      name: "RxSwiftSocketIO",
      targets: ["MSocketIO", "MRxSwiftSocketIO"]),
    .library(
      name: "ReactiveSwiftSocketIO",
      targets: ["MSocketIO", "MReactiveSwiftSocketIO"]),
  ],
  dependencies: [
    .package(url: "https://github.com/Alamofire/Alamofire.git", from: "5.6.4"),
    .package(url: "https://github.com/daltoniam/Starscream.git", from: "4.0.4"),
    .package(url: "https://github.com/ReactiveX/RxSwift.git", from: "6.5.0"),
    .package(url: "https://github.com/ReactiveCocoa/ReactiveSwift.git", from: "7.0.0"),
    .package(name: "SocketIO", url: "https://github.com/socketio/socket.io-client-swift",from: "16.0.1"),
  ],
  targets: [
    /**
     Target BuildRequest
     */
    .target(
      name: "BuildRequest",
      dependencies: ["Alamofire"]
    ),
    //request
    /**
     Target Request
     */
    
      .target(
        name: "MRequest",
        dependencies: ["BuildRequest"],
        path: "Sources/MRequest/MRequest"
      ),
    .target(
      name: "MCombineRequest",
      dependencies: ["MRequest"],
      path: "Sources/MRequest/MRequestCombine"
    ),
    .target(
      name: "MRxSwiftRequest",
      dependencies: ["MRequest", "RxSwift"],
      path: "Sources/MRequest/MRequestRxSwift"
    ),
    .target(
      name: "MReactiveSwiftRequest",
      dependencies: ["MRequest", "ReactiveSwift"],
      path: "Sources/MRequest/MRequestReactiveSwift"
    ),
    /**
     Target WebSocket
     */
    .target(
      name: "MWebSocket",
      dependencies: ["Starscream", "BuildRequest"],
      path: "Sources/MWebSocket/MWebSocket"
    ),
    .target(
      name: "MCombineWebSocket",
      dependencies: ["MWebSocket"],
      path: "Sources/MWebSocket/MWebSocketCombine"
    ),
    .target(
      name: "MRxSwiftWebSocket",
      dependencies: ["MWebSocket", "RxSwift"],
      path: "Sources/MWebSocket/MWebSocketRxSwift"
    ),
    .target(
      name: "MReactiveSwiftWebSocket",
      dependencies: ["MWebSocket", "ReactiveSwift"],
      path: "Sources/MWebSocket/MWebSocketReactiveSwift"
    ),
    /**
     Target SocketIO
     */
    .target(
      name: "MSocketIO",
      dependencies: ["SocketIO", "BuildRequest"],
      path: "Sources/MSocketIO/MSocketIO"
    ),
    .target(
      name: "MCombineSocketIO",
      dependencies: ["MSocketIO"],
      path: "Sources/MSocketIO/MSocketIOCombine"
    ),
    .target(
      name: "MRxSwiftSocketIO",
      dependencies: ["MSocketIO", "RxSwift"],
      path: "Sources/MSocketIO/MSocketIORxSwift"
    ),
    .target(
      name: "MReactiveSwiftSocketIO",
      dependencies: ["MSocketIO", "ReactiveSwift"],
      path: "Sources/MSocketIO/MSocketIOReactiveSwift"
    ),
    /**
     Test Target
     - Request
     - Websocket
     - SocketIO
     */
//    .testTarget(
//      name: "MRequestTests",
//      dependencies: [
//        "Alamofire",
//        "RxSwift",
//        "ReactiveSwift",
//        "MRequest",
//        "MCombineRequest",
//        "MRxSwiftRequest",
//        "MReactiveSwiftRequest"
//      ]
//    ),
//    .testTarget(
//      name: "MWebSocketTests",
//      dependencies: [
//        "Starscream",
//        "RxSwift",
//        "ReactiveSwift",
//        "MWebSocket",
//        "MCombineWebSocket",
//        "MRxSwiftWebSocket",
//        "MReactiveSwiftWebSocket"
//      ]
//    ),
//    .testTarget(
//      name: "MSocketIOTests",
//      dependencies: [
//        "SocketIO",
//        "RxSwift",
//        "ReactiveSwift",
//        "MSocketIO",
//        "MCombineSocketIO",
//        "MRxSwiftSocketIO",
//        "MReactiveSwiftSocketIO"
//      ]
//    ),
  ]
)
