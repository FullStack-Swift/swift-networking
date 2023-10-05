# Networking

### Making Requests
```swift
let urlString = "https://httpbin.org/get"
let request = MRequest {
  RUrl(urlString)
  RPath(path)
  Rbody(data)
  REncoding(JSONEncoding.default)
  RMethod(.get)
  RHeaders()
  RQueryItem()
  RQueryItems()
  /// somthing else
}

let socket = MSocket {
  RUrl(urlString)
  RPath(path)
  Rbody(data)
  REncoding(JSONEncoding.default)
  RMethod(.get)
  RHeaders()
  RQueryItem()
  RQueryItems()
  /// somthing else
}

socket.write(string: "something")

let socketIO = MSocketIO(withSourceURL: URL(urlString: "")!, timeout: 15, connectparams: [:])
socketIO.on("event")
```
### Response Handling

- Async
```swift
/// Data
let data = try await request.data

/// String
let string = try await request.string

/// Result<Data, AFError>
let result = await request.resultData

/// Result<String, AFError>
let result = await request.resultString

/// DataTask<Data>
let data = await request.serializingData

/// DataTask<String>
let string = await request.serializingString
```

- Combine
```swift
request.sink { response in
  debugPrint(response)
}

socket.sink { response in
  debugPrint(response)
 }
 
 socketIO.on("event").sink { dict in
  debugPrint(dict)
}
```
- ReactiveSwift
```swift
request.producer.startWithValues { response in
  debugPrint(response)
}

socket.producer.startWithValues { response in
  debugPrint(response)
}

socketIO.on("event").producer.startWithValues { dict in
  debugPrint(dict)
}
```
- RxSwift
```swift
request.subscribe { response in
  debugPrint(response)
}

socket.subscribe { response in
  debugPrint(response)
}

socketIO.on("event").subscribe { dict in 
  debugPrint(dict)
}
```

- CURL
```swift
let request: = ...
request
.printCURLRequest() // -> Self


request
.cURLDescription { curl in
  // Todo with curl
} // -> Self

```

## Installation

### Swift Package Manager

The [Swift Package Manager](https://swift.org/package-manager/) is a tool for automating the distribution of Swift code and is integrated into the `swift` compiler. 

Once you have your Swift package set up, adding Networking as a dependency is as easy as adding it to the `dependencies` value of your `Package.swift`.

```swift
dependencies: [
    .package(url: "https://github.com/FullStack-Swift/Networking", .upToNextMajor(from: "1.0.0"))
]
```

# Example

https://github.com/FullStack-Swift/TodoList
