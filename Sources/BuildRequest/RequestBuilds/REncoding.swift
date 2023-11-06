import Foundation
import Alamofire

public struct REncoding: RequestProtocol {
  
  private let encoding: any ParameterEncoding
  
  public init(_ encoding: ParameterEncoding = URLEncoding.default) {
    self.encoding = encoding
  }
  
  public func build(request: inout URLRequest) {
    let parameter = request.httpBody?.toDictionary()
    if let newRequest = try? encoding.encode(request, with: parameter) {
      request = newRequest
    }
  }
  
  public var value: ParameterEncoding {
    encoding
  }
  
}

extension REncoding {
  public init(_ initial: () -> any ParameterEncoding) {
    self.init(initial())
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
