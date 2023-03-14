import Foundation
import Combine

// MARK: - Combine
@available(macOS 10.15, iOS 13, watchOS 6, tvOS 13, *)
public extension MRequest {
  typealias Input = DataResponsePublisher<Data>.Output
  
  typealias Output = DataResponsePublisher<Data>.Output
  
  typealias Failure = Never
}
@available(macOS 10.15, iOS 13, watchOS 6, tvOS 13, *)
extension MRequest: Subscriber {
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
extension MRequest: Publisher {
  public func receive<S>(subscriber: S) where S: Subscriber, Never == S.Failure, Output == S.Input {
    publisher().subscribe(subscriber)
  }
}

// MARK: - publisher
@available(macOS 10.15, iOS 13, watchOS 6, tvOS 13, *)
extension MRequest {
  public func publisher() -> AnyPublisher<DataResponsePublisher<Data>.Output, DataResponsePublisher<Data>.Failure> {
    dataRequest.publisher()
  }
}
