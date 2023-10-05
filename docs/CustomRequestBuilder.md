#  Custom Request Builder

```swift
public struct CustomRequest: RequestProtocol {
  /// Initializes a request that does nothing.
  @inlinable
  public init() {
    self.init(internal: ())
  }
  
  @usableFromInline
  init(internal: Void) {}
  
  @inlinable
  public func build(request: inout URLRequest) {
    /// nothing todo
  }
}

```
