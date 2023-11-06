import Foundation

public struct RAny: RequestProtocol {

  let request: any RequestProtocol
  
  public init(_ request: any RequestProtocol) {
    self.request = request
  }
  
  public func build(request: inout URLRequest) {
    self.request.build(request: &request)
  }
  
  public var value: any RequestProtocol {
    request
  }
  
  public func `as`<R: RequestProtocol>(_ type: R.Type) -> R? {
    self.request as? R
  }
  
  public func `is`<R: RequestProtocol>(_ type: R.Type) -> Bool {
    return (request is R)
  }
}

extension RequestProtocol {
  public func eraseToRAny() -> RAny {
    RAny(self)
  }
  
  public func `as`<R: RequestProtocol>(_ type: R.Type) -> R? {
    if let rAny = self as? RAny {
      return rAny.as(type)
    } else {
      return self as? R
    }
  }
  
  public func `is`<R: RequestProtocol>(_ type: R.Type) -> Bool {
    if let rAny = self as? RAny {
      return rAny.is(type)
    } else {
      return (self is R)
    }
  }
}
