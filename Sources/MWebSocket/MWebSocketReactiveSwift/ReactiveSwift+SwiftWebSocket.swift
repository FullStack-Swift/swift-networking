import Foundation
import ReactiveSwift

// MARK: - ReactiveSwift
extension MWebSocket: SignalProducerProtocol, SignalProducerConvertible {
  public var producer: SignalProducer<WebSocketEvent,Never> {
    publisher()
  }
}

extension MWebSocket {
  public func publisher() -> SignalProducer<WebSocketEvent, Never> {
    return SignalProducer{ [weak self] (observer, disposable) in
      guard let self else { return }
      self.socket?.onEvent = { event in
        observer.send(value: event)
      }
      disposable.observeEnded {
        self.socket?.forceDisconnect()
      }
    }
  }
}
