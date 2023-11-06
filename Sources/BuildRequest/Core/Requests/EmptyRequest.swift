import Foundation

public struct EmptyRequest: RequestProtocol {
  
  public typealias Value = Void
  
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
  
  public var value: Void {
    return
  }
}
