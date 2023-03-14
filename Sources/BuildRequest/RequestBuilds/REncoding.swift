import Foundation
import Alamofire

public struct REncoding: RequestBuilderProtocol {
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

fileprivate extension Data {
  func toDictionary() -> [String: Any]? {
    do {
      let json = try JSONSerialization.jsonObject(with: self)
      return json as? [String: Any]
    } catch {
      return nil
    }
  }
}
