import Foundation

public struct RQueryItem: RequestBuilderProtocol {
  private var key: String
  private var value: String
  
  public init(_ key: String, value: String) {
    self.key = key
    self.value = value
  }
  
  public func build(request: inout URLRequest) {
    guard let url = request.url,
          var components = URLComponents(string: url.absoluteString)
    else { return }
    var queryItems = components.queryItems ?? []
    queryItems += [urlQueryItem]
    components.queryItems = queryItems
    request.url = components.url
  }
}

extension RQueryItem {
  var urlQueryItem: URLQueryItem {
    URLQueryItem(name: key, value: value)
  }
}
