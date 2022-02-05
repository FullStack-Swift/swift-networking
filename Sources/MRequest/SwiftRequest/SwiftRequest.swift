import Foundation
import BuildRequest

public typealias MRequest = SwiftRequest

final public class SwiftRequest {
  public var urlSessionConfiguration: URLSessionConfiguration?
  public var urlRequest: URLRequest
  public var parameter: RequestBuilderProtocol
  
  public init(
    urlRequest: URLRequest? = nil,
    urlSessionConfiguration: URLSessionConfiguration? = nil,
    @RequestBuilder builder: () -> RequestBuilderProtocol
  ) {
    self.urlSessionConfiguration = urlSessionConfiguration
    self.urlRequest = urlRequest ?? URLRequest(url: URL(string: "https://")!)
    self.parameter = builder()
    parameter.build(request: &self.urlRequest)
  }
}

// MARK: Data Request
public extension SwiftRequest {
  var dataRequest: DataRequest {
    guard let configuration = self.urlSessionConfiguration else {
      return AF.request(urlRequest)
    }
    let session = Session(configuration: configuration)
    return session.request(urlRequest)
  }
}

// MARK: CURL Description
public extension SwiftRequest {
  func printCURLRequest(
    filename: String = #file,
    line: Int = #line,
    funcName: String = #function
  ) -> Self {
    func sourceFileName(filePath: String) -> String {
      let components = filePath.components(separatedBy: "/")
      if let componentLast = components.last {
        return componentLast
      } else {
        return ""
      }
    }
    dataRequest
      .cURLDescription(calling: { value in
        let value = value.dropFirst(2)
        Swift.print("⚠️ cURLDescription [[\(sourceFileName(filePath: filename))]:\(line) \(funcName)]")
        Swift.print(value)
      })
    return self
  }
  
  func cURLDescription(_ cURL: @escaping(String) -> Void) -> Self {
    dataRequest
      .cURLDescription(calling: cURL)
    return self
  }
}
