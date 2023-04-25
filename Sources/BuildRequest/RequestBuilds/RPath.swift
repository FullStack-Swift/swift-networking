import Foundation

public struct RPath: RequestProtocol {
  private let path: String?
  
  public init(path: String?) {
    self.path = path
  }
  
  public func build(request: inout URLRequest) {
    guard let urlString = request.url?.absoluteString else {
      return
    }
    guard let path = path else {
      return
    }
    if urlString.last == "/" {
      request.url = URL(string: urlString + path)
    } else {
      request.url = URL(string: (urlString + "/" + path))
    }
  }
}

extension RPath: CustomStringConvertible {
  public var description: String {
    path ?? "Null"
  }
}

extension RPath: CustomDebugStringConvertible {
  public var debugDescription: String {
    description
  }
}
