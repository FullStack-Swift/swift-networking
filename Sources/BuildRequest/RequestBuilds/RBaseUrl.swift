import Foundation

public struct RBaseUrl: RequestProtocol {
  private let urlString: String
  
  public init(urlString: String) {
    self.urlString = urlString
  }
  
  public func build(request: inout URLRequest) {
    request.url = URL(string: urlString)
  }
}

public extension RBaseUrl {
  func withPath(_ path: String?) -> RBaseUrl {
    if let path = path {
      if urlString.last == "/" {
        return .init(urlString: (urlString + path))
      } else {
        return .init(urlString: (urlString + "/" + path))
      }
    } else {
      return self
    }
  }
}

extension RBaseUrl: CustomStringConvertible {
  public var description: String {
    urlString
  }
}

extension RBaseUrl: CustomDebugStringConvertible {
  public var debugDescription: String {
    description
  }
}
