import Foundation

public struct _SequenceMany: RequestProtocol {
  
  public var requests: [RequestProtocol]
  
  public init(requests: [RequestProtocol] = []) {
    self.requests = requests
  }
  
  public func build(request: inout URLRequest) {
    executing(request: &request, requests: requests)
  }
}

// MARK: Get Properties
extension _SequenceMany {
  public func getRequest<R: RequestProtocol>(
    _ type: R.Type
  ) -> R? {
    for item in requests where item is R {
      return item as? R
    }
    return nil
  }
  
  public var rBaseUrl: RBaseUrl? {
    getRequest(RBaseUrl.self)
  }
  
  public var rUrl: RUrl? {
    getRequest(RUrl.self)
  }
  
  public var rPath: RPath? {
    getRequest(RPath.self)
  }
  
  public var rBody: Rbody? {
    getRequest(Rbody.self)
  }
  
  public var rMethod: RMethod? {
    getRequest(RMethod.self)
  }
  
  public var rEndCoding: REncoding? {
    getRequest(REncoding.self)
  }
  
  public var rHeaders: RHeaders? {
    getRequest(RHeaders.self)
  }
  
  public var rQueryItem: RQueryItem? {
    getRequest(RQueryItem.self)
  }
  
  public var rQueryItems: RQueryItems? {
    getRequest(RQueryItems.self)
  }
}

// MARK: Remove Properties
extension _SequenceMany {
  @discardableResult
  public mutating func remove<R: RequestProtocol>(
    _ type: R.Type
  ) -> Self {
    self.requests.removeAll(where: {$0 is R})
    return self
  }
  
  @discardableResult
  public mutating func removeRBaseUrl() -> Self {
    remove(RBaseUrl.self)
  }
  
  @discardableResult
  public mutating func removeRUrl() -> Self {
    remove(RUrl.self)
  }
  
  
  @discardableResult
  public mutating func removeRPath() -> Self {
    remove(RPath.self)
  }
  
  @discardableResult
  public mutating func removeRBody() -> Self {
    remove(Rbody.self)
  }
  
  @discardableResult
  public mutating func removeRMethod() -> Self {
    remove(RMethod.self)
  }
  
  @discardableResult
  public mutating func removeREncoding() -> Self {
    remove(REncoding.self)
  }
  
  @discardableResult
  public mutating func removeRHeaders() -> Self {
    remove(RHeaders.self)
  }
  
  @discardableResult
  public mutating func removeRQueryItem() -> Self {
    remove(RQueryItem.self)
  }
  
  @discardableResult
  public mutating func removeRQueryItems() -> Self {
    remove(RQueryItems.self)
  }
}

extension _SequenceMany: CustomStringConvertible {
  public var description: String {
    var description = ""
    for item in requests {
      var desc = item.description
      desc += "\n"
      description += desc
    }
    return description
  }
}

extension _SequenceMany: CustomDebugStringConvertible {
  public var debugDescription: String {
    description
  }
}
