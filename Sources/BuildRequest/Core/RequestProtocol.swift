import Foundation

public protocol RequestProtocol: CustomStringConvertible, CustomDebugStringConvertible {
  func build(request: inout URLRequest)
}

extension RequestProtocol {
  
  /// Description
  /// - Parameter mutation: mutation your Request
  /// - Returns: Self
  public func with(_ mutation: (inout Self) -> Void) -> Self {
    var this = self
    mutation(&this)
    return this
  }
  
  /// Applies the given transform if the given condition evaluates to `true`.
  /// - Parameters:
  ///   - condition: The condition to evaluate.
  ///   - transform: The transform to apply to the source `RequestProtocol`.
  /// - Returns: Either the original `RequestProtocol` or the modified `RequestProtocol` if the condition is `true`.
  @RequestBuilder
  public func `if`<Transform: RequestProtocol>(
    _ condition: Bool, @RequestBuilder transform: (Self) -> Transform
  ) -> any RequestProtocol {
    if condition {
      transform(self)
        .eraseToRAny()
    } else {
      self
        .eraseToRAny()
    }
  }
  
  
  /// Applies the given transform `transform` or `else`.
  /// - Parameters:
  ///   - condition: The condition to evaluate.
  ///   - transform: The transform to apply to the source `RequestProtocol`.
  ///   - else: The transform that applies if `condition` is false
  /// - Returns: Either the original `RequestProtocol` or the modified `RequestProtocol` based on the condition`.
  @RequestBuilder
  public func `if`<Content: RequestProtocol>(
    _ condition: Bool, transform: (Self) -> Content,
    @RequestBuilder else: (Self) -> Content
  ) -> any RequestProtocol {
    if condition {
      transform(self)
        .eraseToRAny()
    } else {
      `else`(self)
        .eraseToRAny()
    }
  }
  
  /// Unwraps the given `value` and applies the given `transform`.
  /// - Parameters:
  ///   - value: The value to unwrap.
  ///   - transform: The transform to apply to the source `RequestProtocol`.
  /// - Returns: Either the original `RequestProtocol` or the modified `RequestProtocol` with unwrapped `value` if the `value` is not nil`.
  @RequestBuilder
  public func ifLet<Value, Content: RequestProtocol>(
    _ value: Value?,
    @RequestBuilder transform: (Value, Self) -> Content
  ) -> any RequestProtocol {
    if let value = value {
      transform(value, self)
        .eraseToRAny()
    } else {
      self
        .eraseToRAny()
    }
  }
  
  /// Unwraps the given `value` and applies the given `transform`.
  /// - Parameters:
  ///   - value: The value to unwrap.
  ///   - transform: The transform to apply to the source `RequestProtocol`.
  ///   - else:The transform that applies if `value` is nil
  /// - Returns: Either the `else` transform or the modified `RequestProtocol` with unwrapped `value` if the `value` is not nil`.
  @RequestBuilder
  public func ifLet<Value, Content: RequestProtocol>(
    _ value: Value?,
    @RequestBuilder transform: (Value, Self) -> Content,
    @RequestBuilder else: (Self) -> Content
  ) -> any RequestProtocol {
    if let value = value {
      transform(value, self)
        .eraseToRAny()
    } else {
      `else`(self)
        .eraseToRAny()
    }
  }
}

extension RequestProtocol {
  
  public func build(request: URLRequest) { }
  
  public func executing(request: inout URLRequest, requests: [RequestProtocol] = []) {
    if requests.isEmpty { return }
//    var items: [RequestProtocol] = []
//    items.append(contentsOf: requests.filter({$0 is RUrl}))
//    items.append(contentsOf: requests.filter({$0 is RPath}))
//    items.append(contentsOf: requests.filter({!($0 is RUrl || $0 is REncoding || $0 is RPath)}))
//    items.append(contentsOf: requests.filter({$0 is REncoding}))
    
    let items: [RequestProtocol] = requests.cRequests()
    /// build
    items.forEach {
      $0.build(request: &request)
    }
  }
  
  var typeName: String {
    String(describing: Self.self)
  }
  
  static var typeName: String {
    String(describing: Self.self)
  }

  public var description: String {
    typeName
  }
  
  public var debugDescription: String {
    description
  }
}

extension Array where Element == any RequestProtocol {
  var rUrl: [Element] {
    requests(RUrl.self)
  }
  
  var rPath: [Element] {
    requests(RPath.self)
  }
  
  var rBody: [Element] {
    requests(Rbody.self)
  }
  
  var rMethod: [Element] {
    requests(RMethod.self)
  }
  
  var rEncoding: [Element] {
    requests(REncoding.self)
  }
  
  var rHeader: [Element] {
    requests(RHeaders.self)
  }
  
  var rQueryItem: [Element] {
    requests(RQueryItem.self)
  }
  
  var rQueryItems: [Element] {
    requests(RQueryItems.self)
  }
  
  var rOther: [Element] {
    self.remove {
      $0.is(RUrl.self) || $0.is(RPath.self) ||
      $0.is(RMethod.self) || $0.is(Rbody.self) ||
      $0.is(RHeaders.self) || $0.is(RQueryItem.self) ||
      $0.is(RQueryItems.self) || $0.is(REncoding.self)
    }
  }
  
  func cRequests() -> [RequestProtocol] {
    rUrl + rPath + rMethod + rBody + rHeader + rQueryItem + rQueryItems + rOther + rEncoding
  }
  
  func requests<R: RequestProtocol>(_ type: R.Type) -> [Element] {
    self.filter({$0.is(R.self)})
  }
  
  func remove(ifTrue: (Element) -> Bool) -> Self {
    var clone = self
    clone.removeAll {
      ifTrue($0)
    }
    return clone
  }
}
