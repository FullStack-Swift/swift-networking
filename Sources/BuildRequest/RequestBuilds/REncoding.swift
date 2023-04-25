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

extension REncoding: CustomStringConvertible {
  public var description: String {
    String(describing: encoding)
  }
}

extension REncoding: CustomDebugStringConvertible {
  public var debugDescription: String {
    description
  }
}
