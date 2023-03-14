import Foundation
import Combine

// MARK: - DataRequest -> Publisher in Combine
@available(macOS 10.15, iOS 13, watchOS 6, tvOS 13, *)
extension DataRequest {
  /// Description
  /// - Returns: AnyPublisher
  func publisher() -> AnyPublisher<DataResponsePublisher<Data>.Output, DataResponsePublisher<Data>.Failure> {
    publishData().eraseToAnyPublisher()
  }
}
