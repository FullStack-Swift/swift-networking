import Foundation
import Combine

// MARK: - Combine
@available(macOS 10.15, iOS 13, watchOS 6, tvOS 13, *)
public extension MRequest {
  typealias Input = AFOutput
  
  typealias Output = AFOutput
  
  typealias Failure = AFFailure
}

@available(macOS 10.15, iOS 13, watchOS 6, tvOS 13, *)
extension MRequest: Subscriber {
  public func receive(completion: Subscribers.Completion<Never>) {
  }
  
  public func receive(_ input: Input) -> Subscribers.Demand {
    return .none
  }
  
  public func receive(subscription: Subscription) {

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
  public func publisher() -> AFPublisher {
    dataRequest.publisher()
  }
}
