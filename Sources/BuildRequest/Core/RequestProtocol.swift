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
    items.append(contentsOf: requests.filter({$0 is RUrl}))
    items.append(contentsOf: requests.filter({$0 is RPath}))
    items.append(contentsOf: requests.filter({$0 is Rbody}))
    items.append(contentsOf: requests.filter({$0 is RMethod}))
    items.append(contentsOf: requests.filter({$0 is RHeaders}))
    items.append(contentsOf: requests.filter({$0 is RQueryItem || $0 is RQueryItems}))
    items.append(contentsOf: requests.filter({$0 is REncoding}))
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
