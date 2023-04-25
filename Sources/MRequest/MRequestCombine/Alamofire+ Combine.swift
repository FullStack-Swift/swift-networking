import Foundation
import Combine

@available(macOS 10.15, iOS 13, watchOS 6, tvOS 13, *)
public typealias AFOutput = DataResponsePublisher<Data>.Output

@available(macOS 10.15, iOS 13, watchOS 6, tvOS 13, *)
public typealias AFFailure = DataResponsePublisher<Data>.Failure

@available(macOS 10.15, iOS 13, watchOS 6, tvOS 13, *)
public typealias AFPublisher = AnyPublisher<AFOutput, AFFailure>

// MARK: - DataRequest -> Publisher in Combine
@available(macOS 10.15, iOS 13, watchOS 6, tvOS 13, *)
extension DataRequest {
  /// Description
  /// - Returns: AnyPublisher
  func publisher() -> AFPublisher {
    publishData().eraseToAnyPublisher()
  }
}
