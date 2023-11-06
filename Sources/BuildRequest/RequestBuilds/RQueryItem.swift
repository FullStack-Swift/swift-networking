import Foundation

public struct RQueryItem: RequestProtocol {
  private var _key: String
  private var _value: String
  
  public init(_ key: String, value: String) {
    self._key = key
    self._value = value
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
  
  public var value: (String, String) {
    (_key, _value)
  }
}

extension RQueryItem {
  public init(_ key: () -> String, _ value: () -> String) {
    self.init(key(), value: value())
  }
  
  public init(_ key: String, _ value: () -> String) {
    self.init(key, value: value())
  }
  
  public init(_ key: () -> String, value: String) {
    self.init(key(), value: value)
  }
}

extension RQueryItem {
  var urlQueryItem: URLQueryItem {
    URLQueryItem(name: _value, value: _value)
  }
}

extension RQueryItem {
  public var description: String {
    [typeName: [_key: _value].toString() ?? "nil"].description
  }
}
extension RQueryItem {
  public var debugDescription: String {
    description
  }
}
