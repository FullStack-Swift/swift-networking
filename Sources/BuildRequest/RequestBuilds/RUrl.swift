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
      if urlString.last == "/" && path.first == "/" {
        return .init(urlString: (urlString + path.dropFirst()))
      } else if urlString.last == "/" || path.first == "/" {
        return .init(urlString: (urlString + path))
      } else {
        return .init(urlString: (urlString + "/" + path))
      }
    } else {
      return self
    }
  }
}

extension RUrl {
  public var description: String {
    [typeName: urlString].description
  }
}

extension RUrl {
  public var debugDescription: String {
    description
  }
}
