import Foundation

public struct RUrl: RequestProtocol {
  private let urlString: String
  
  public init(_ urlString: String) {
    self.urlString = urlString
  }
  
  public func build(request: inout URLRequest) {
    request.url = URL(string: urlString)
  }
}

extension RUrl {
  public init(_ initial: () -> String) {
    self.init(initial())
  }
}

extension RUrl {
  public func withPath(_ path: String?) -> RUrl {
    let forwardSlash: Character = "/"
    if let path = path {
      if urlString.last == forwardSlash && path.first == forwardSlash {
        return .init((urlString + path.dropFirst()))
      } else if urlString.last == forwardSlash || path.first == forwardSlash {
        return .init((urlString + path))
      } else {
        return .init((urlString + String(forwardSlash) + path))
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
