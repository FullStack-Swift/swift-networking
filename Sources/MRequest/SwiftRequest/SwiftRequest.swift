import Foundation
import BuildRequest

public typealias MRequest = SwiftRequest

final public class SwiftRequest {
  public var urlSessionConfiguration: URLSessionConfiguration?
  public var urlRequest: URLRequest
  public var parameter: RequestBuilderProtocol
  
  public init(urlRequest: URLRequest? = nil,
              urlSessionConfiguration: URLSessionConfiguration? = nil,
              @RequestBuilder builder: () -> RequestBuilderProtocol) {
    self.urlSessionConfiguration = urlSessionConfiguration
    self.urlRequest = urlRequest ?? URLRequest(url: URL(string: "https://")!)
    self.parameter = builder()
    parameter.build(request: &self.urlRequest)
  }
}
