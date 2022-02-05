import Foundation

public struct RQueryItems: RequestBuilderProtocol {
  
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
    guard let queryItem else { return }
    children = queryItem.compactMapValues{"\($0)"}.map {
      RQueryParam($0.key, value: $0.value)
    }
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
