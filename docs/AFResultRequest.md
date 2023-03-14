#  AFResultRequest

```swift

import Alamofire
import SwiftRequest
import Combine
import Foundation

// MARK: - Custom Response Request
final public class AFResultRequest {
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
public extension AFResultRequest {
  var dataRequest: DataRequest {
    guard let configuration = self.urlSessionConfiguration else {
      return AF.request(urlRequest)
    }
    let session = Session(configuration: configuration)
    return session.request(urlRequest)
  }
}

// MARK: CURL Description
public extension AFResultRequest {
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

@available(macOS 10.15, iOS 13, watchOS 6, tvOS 13, *)
extension AFResultRequest: Subscriber {
  public typealias Input = DataResponsePublisher<Data>.Output
  public typealias Failure = Never

  public func receive(completion: Subscribers.Completion<Never>) {
  }

  public func receive(_ input: Input) -> Subscribers.Demand {
    return .none
  }

  public func receive(subscription: Subscription) {
    subscription.request(.max(1))
  }
}
@available(macOS 10.15, iOS 13, watchOS 6, tvOS 13, *)
extension AFResultRequest: Publisher {

  public typealias Output = AFResult<Data>

  public func receive<S>(subscriber: S) where S : Subscriber, Failure == S.Failure, Output == S.Input {
    dataRequest.publisher()
      .map(\.result)
      .eraseToAnyPublisher()
      .subscribe(subscriber)
  }
}

```
