import Foundation
import Alamofire

public struct REncoding: RequestProtocol {
  private let encoding: ParameterEncoding
  
  public init(_ encoding: ParameterEncoding = URLEncoding.default) {
    self.encoding = encoding
  }
  
  public func build(request: inout URLRequest) {
    let parameter = request.httpBody?.toDictionary()
    if let newRequest = try? encoding.encode(request, with: parameter) {
      request = newRequest
    }
  }
}

extension REncoding {
  public var description: String {
    [typeName: encoding.typeName].description
  }
}

extension REncoding {
  public var debugDescription: String {
    description
  }
}

fileprivate extension ParameterEncoding {
  var typeName: String {
    String(describing: Self.self)
  }
}
