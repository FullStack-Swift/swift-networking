import Foundation

public struct RMethod: RequestProtocol {
  private let httpMethod: HTTPMethod?
  
  public init(_ httpMethod: HTTPMethod) {
    self.httpMethod = httpMethod
  }
  
  public func build(request: inout URLRequest) {
    request.method = self.httpMethod
  }
}

extension RMethod: CustomStringConvertible {
  public var description: String {
    httpMethod?.rawValue ?? "Null"
  }
}

extension RMethod: CustomDebugStringConvertible {
  public var debugDescription: String {
    description
  }
}
