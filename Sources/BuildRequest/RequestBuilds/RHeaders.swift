import Foundation

public struct RHeaders: RequestProtocol {
  private let headers: HTTPHeaders
  
  public init(headers: HTTPHeaders) {
    self.headers = headers
  }
  
  public func build(request: inout URLRequest) {
    request.allHTTPHeaderFields = headers.dictionary
  }
}

extension RHeaders: CustomStringConvertible {
  public var description: String {
    headers.dictionary.toString() ?? "Null"
  }
}

extension RHeaders: CustomDebugStringConvertible {
  public var debugDescription: String {
    description
  }
}
