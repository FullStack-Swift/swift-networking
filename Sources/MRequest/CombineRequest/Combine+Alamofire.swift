import Alamofire
import Combine
import Foundation
@available(macOS 10.15, iOS 13, watchOS 6, tvOS 13, *)
extension DataRequest {
  func publisher() -> AnyPublisher<DataResponsePublisher<Data>.Output, DataResponsePublisher<Data>.Failure> {
    publishData().eraseToAnyPublisher()
  }
}
