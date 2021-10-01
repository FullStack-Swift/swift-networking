import ReactiveSwift
import SwiftRequest
import SwiftWebSocket
import Foundation

  // MARK: - ReactiveSwift
extension SwiftWebSocket: SignalProducerProtocol, SignalProducerConvertible {
  public var producer: SignalProducer<WebSocketEvent,Never> {
    publisher()
  }
}

extension SwiftWebSocket {
  public func publisher() -> SignalProducer<WebSocketEvent, Never> {
    return SignalProducer{ [weak self](observer, disposable) in
      guard let self = self else {
        return
      }
      self.socket?.onEvent = { event in
        observer.send(value: event)
      }
      disposable.observeEnded {
        self.socket?.forceDisconnect()
      }
    }
  }
}
