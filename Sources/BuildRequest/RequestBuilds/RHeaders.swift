import Foundation

public struct RHeaders: RequestProtocol {
  
  private let headers: HTTPHeaders
  
  public init(_ headers: HTTPHeaders) {
    self.headers = headers
  }
  
  public func build(request: inout URLRequest) {
    request.allHTTPHeaderFields = headers.dictionary
  }
  
  public var value: [String: String] {
    headers.dictionary
  }
}

extension RHeaders {
  public init(_ initial: () -> HTTPHeaders) {
    self.init(initial())
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
