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

extension RMethod {
  public init(_ initial: () -> HTTPMethod) {
    self.init(initial())
  }
}

extension RMethod {
  public var description: String {
    [typeName: httpMethod?.rawValue ?? "nil"].description
  }
}

extension RMethod {
  public var debugDescription: String {
    description
  }
}
