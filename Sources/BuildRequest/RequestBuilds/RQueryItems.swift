import Foundation

public struct RQueryItems: RequestProtocol {
  
  private let children: [RQueryItem]
  
  public func build(request: inout URLRequest) {
    guard let url = request.url,
          var components = URLComponents(string: url.absoluteString)
    else { return }
    var queryItems = components.queryItems ?? []
    queryItems += urlQueryItems
    components.queryItems = queryItems
    request.url = components.url
  }
  
  public init(_ queryItem: [String: Any]? = nil) {
    children = queryItem?.compactMapValues{"\($0)"}.map {
      RQueryItem($0.key, value: $0.value)
    } ?? []
  }
  
  public init(_ queryItem: Data? = nil) {
    self.init(queryItem?.toDictionary())
  }
  
  public init(_ queryItem: String? = nil) {
    self.init(queryItem?.toDictionary())
  }
  
  public init(_ params: [RQueryItem]) {
    self.children = params
  }
}

extension RQueryItems {
  public init(_ initial: () -> [String: Any]?) {
    self.init(initial())
  }
  
  public init(_ initial: () -> Data?) {
    self.init(initial()?.toDictionary())
  }
  
  public init(_ initial: () -> String?) {
    self.init(initial()?.toDictionary())
  }

  public init(_ initial: () -> [RQueryItem]) {
    self.init(initial())
  }
}

extension RQueryItems {
  var urlQueryItems: [URLQueryItem] {
    children.map { $0.urlQueryItem }
  }
}

extension RQueryItems {
  public var description: String {
    [typeName: children].description
  }
}

extension RQueryItems {
  public var debugDescription: String {
    description
  }
}
