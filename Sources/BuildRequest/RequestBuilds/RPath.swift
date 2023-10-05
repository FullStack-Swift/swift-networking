import Foundation

public struct RPath: RequestProtocol {
  private let path: String?
  
  public init(_ path: String?) {
    self.path = path
  }
  
  public func build(request: inout URLRequest) {
    guard let urlString = request.url?.absoluteString else {
      return
    }
    if let path = path {
      if urlString.last == "/" && path.first == "/" {
        request.url = URL(string: urlString + path.dropFirst())
      } else if urlString.last == "/" || path.first == "/" {
        request.url = URL(string: urlString + path)
      } else {
        request.url = URL(string: (urlString + "/" + path))
      }
    }
  }
}

extension RPath {
  public init(_ initial: () -> String?) {
    self.init(initial())
  }
}


extension RPath {
  public var description: String {
    [typeName: path ?? "nil"].description
  }
}

extension RPath {
  public var debugDescription: String {
    description
  }
}
