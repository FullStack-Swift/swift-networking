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
  
  public init(_ params: [RQueryItem]) {
    self.children = params
  }
}

extension RQueryItems {
  var urlQueryItems: [URLQueryItem] {
    children.map { $0.urlQueryItem }
  }
}

extension RQueryItems: CustomStringConvertible {
  public var description: String {
    children.map({$0.description}).toDictionary()?.toString() ?? "Null"
  }
}

extension RQueryItems: CustomDebugStringConvertible {
  public var debugDescription: String {
    description
  }
}
