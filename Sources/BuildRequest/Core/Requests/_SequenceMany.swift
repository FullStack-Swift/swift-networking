import Foundation

public struct _SequenceMany: RequestProtocol {

  public var requests: [RequestProtocol]

  public init(requests: [RequestProtocol] = []) {
    self.requests = requests
  }

  public init(ArrayRequestBuilder builder: () -> [RequestProtocol]) {
    self.requests = builder()
  }

  public func build(request: inout URLRequest) {
    executing(request: &request, requests: requests)
  }
}

// MARK: Get Properties
extension _SequenceMany {
  public func getRequestProtocol<R: RequestProtocol>(
    _ type: R.Type
  ) -> R? {
    for item in requests where item is R {
      return item as? R
    }
    return nil
  }

  public var rBody: Rbody? {
    getRequestProtocol(Rbody.self)
  }

  public var rMethod: RMethod? {
    getRequestProtocol(RMethod.self)
  }

  public var rUrl: RUrl? {
    getRequestProtocol(RUrl.self)
  }

  public var rPath: RPath? {
    getRequestProtocol(RPath.self)
  }

  public var rEndCoding: REncoding? {
    getRequestProtocol(REncoding.self)
  }

  public var rHeaders: RHeaders? {
    getRequestProtocol(RHeaders.self)
  }

  public var rQueryItem: RQueryItem? {
    getRequestProtocol(RQueryItem.self)
  }

  public var rQueryItems: RQueryItems? {
    getRequestProtocol(RQueryItems.self)
  }
}

  // MARK: Remove Properties
extension _SequenceMany {
  @discardableResult
  public mutating func remove<R: RequestProtocol>(_ type: R.Type) -> Self {
    self.requests.removeAll(where: {$0 is R})
    return self
  }

  public mutating func removeRBody() -> Self {
    remove(Rbody.self)
  }

  public mutating func removeRHeaders() -> Self {
    remove(RHeaders.self)
  }
}
