# Networking

### Swift Package Manager

The [Swift Package Manager](https://swift.org/package-manager/) is a tool for automating the distribution of Swift code and is integrated into the `swift` compiler. 

Once you have your Swift package set up, adding Networking as a dependency is as easy as adding it to the `dependencies` value of your `Package.swift`.

```swift
        let request = MRequest {
          RMethod(.get)
          RUrl(urlString: environment.urlString)
        }
```

```swift
dependencies: [
    .package(url: "https://github.com/FullStack-Swift/Networking", .upToNextMajor(from: "1.0.0"))
]
```

# Example

https://github.com/FullStack-Swift/TodoFullStackSwift
