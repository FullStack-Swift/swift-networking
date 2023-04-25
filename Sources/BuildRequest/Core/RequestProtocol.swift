import Foundation

public protocol RequestProtocol: CustomStringConvertible, CustomDebugStringConvertible {
  func build(request: inout URLRequest)
}

extension RequestProtocol {
  
  public func build(request: URLRequest) {
    
  }
  
  public func executing(
    request: inout URLRequest,
    requests: [RequestProtocol]
  ) {
    if requests.isEmpty { return }
    var items: [RequestProtocol] = []
    for item in requests {
      if item is RBaseUrl {
        items.append(item)
      }
      if item is RUrl {
        items.append(item)
      }
      if item is RPath {
        items.append(item)
      }
      if item is RMethod {
        items.append(item)
      }
      if item is Rbody {
        items.append(item)
      }
      
      if item is RHeaders {
        items.append(item)
      }
      if (item is RQueryItem) || (item is RQueryItems) {
        items.append(item)
      }
      if item is REncoding {
        items.append(item)
      }
    }
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
