import Foundation
import ReactiveSwift

public extension MSocketIO {
  func on(_ event: String) -> SignalProducer<[String: Any], Never> {
    return SignalProducer{ [weak self] (observer, disposable) in
      guard let self else { return }
      self.socket.on(event) { (data, ack) in
        if let dict = data.first as? [String: Any] {
          observer.send(value: dict)
        }
      }
    }
  }
  
  func onAnyEvent() -> SignalProducer<SocketAnyEvent, Never> {
    return SignalProducer{ [weak self] (observer, disposable) in
      guard let self else { return }
      self.socket.onAny { anyEvent in
        observer.send(value: anyEvent)
      }
    }
  }
  
  func on(clientEvents: [SocketClientEvent]) -> SignalProducer<SocketClientEvent, Never> {
    return SignalProducer{ [weak self] (observer, disposable) in
      guard let self else { return }
      var ids = [UUID]()
      for event in SocketClientEvent.allCases where clientEvents.contains(event) {
        let id = self.socket.on(clientEvent: event) { _, _ in
          observer.send(value: event)
        }
        ids.append(id)
        disposable.observeEnded {
          for id in ids {
            self.socket.off(id: id)
          }
        }
      }
    }
  }
}
