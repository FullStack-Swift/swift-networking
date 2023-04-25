import Foundation

public struct RUrl: RequestProtocol {
  private let urlString: String
  
  public init(urlString: String) {
    self.urlString = urlString
  }
  
  public func build(request: inout URLRequest) {
    request.url = URL(string: urlString)
  }
}

extension RUrl {
  public func withPath(_ path: String?) -> RUrl {
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

extension RUrl: CustomStringConvertible {
  public var description: String {
    urlString
  }
}

extension RUrl: CustomDebugStringConvertible {
  public var debugDescription: String {
    description
  }
}
