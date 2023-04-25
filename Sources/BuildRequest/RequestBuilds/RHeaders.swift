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

extension RHeaders {
  public var description: String {
    [typeName: headers.dictionary.toString() ?? "nil"].description
  }
}

extension RHeaders {
  public var debugDescription: String {
    description
  }
}
