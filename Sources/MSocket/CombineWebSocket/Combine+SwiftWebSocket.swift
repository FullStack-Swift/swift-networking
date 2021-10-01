import SwiftWebSocket
import SwiftRequest
import Combine
import Foundation

  // MARK: - Combine
@available(macOS 10.15, iOS 13, watchOS 6, tvOS 13, *)
public extension SwiftWebSocket {
  typealias Input = WebSocketEvent
  
  typealias Output = WebSocketEvent
  
  typealias Failure = Never
}
@available(macOS 10.15, iOS 13, watchOS 6, tvOS 13, *)
extension SwiftWebSocket: Subscriber {
  public func receive(completion: Subscribers.Completion<Never>) {
    
  }
  
  public func receive(_ input: Input) -> Subscribers.Demand {
    return .none
  }
  
  public func receive(subscription: Subscription) {
    subscription.request(.unlimited)
  }
}
@available(macOS 10.15, iOS 13, watchOS 6, tvOS 13, *)
extension SwiftWebSocket: Publisher {
  public func receive<S>(subscriber: S) where S: Subscriber, Never == S.Failure, Output == S.Input {
    publisher().subscribe(subscriber)
  }
}

@available(macOS 10.15, iOS 13, watchOS 6, tvOS 13, *)
extension SwiftWebSocket {
  public func publisher() -> AnyPublisher<WebSocketEvent, Never> {
    let subject = PassthroughSubject<WebSocketEvent, Never>()
    self.socket?.onEvent = { event in
      subject.send(event)
    }
    return subject.eraseToAnyPublisher()
  }
}
