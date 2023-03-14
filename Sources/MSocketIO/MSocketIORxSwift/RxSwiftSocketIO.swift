import Foundation
import RxSwift

public extension MSocketIO {
  func on(_ event: String) -> Observable<[String: Any]> {
    Observable<[String: Any]>.create { [weak self] observer in
      guard let self else { return Disposables.create {} }
      self.socket.on(event) { (data, ack) in
        if let dict = data.first as? [String: Any] {
          observer.onNext(dict)
        }
      }
      return Disposables.create {}
    }
  }
  
  func onAnyEvent() -> Observable<SocketAnyEvent> {
    Observable<SocketAnyEvent>.create { [weak self] observer in
      guard let self else { return Disposables.create {} }
      self.socket.onAny { anyEvent in
        observer.onNext(anyEvent)
      }
      return Disposables.create {}
    }
  }
  
  func on(clientEvents: [SocketClientEvent]) -> Observable<SocketClientEvent> {
    Observable<SocketClientEvent>.create { [weak self] observer in
      guard let self else { return Disposables.create {} }
      var ids = [UUID]()
      for event in SocketClientEvent.allCases where clientEvents.contains(event) {
        let id = self.socket.on(clientEvent: event) { _, _ in
          observer.onNext(event)
        }
        ids.append(id)
      }
      return Disposables.create {
        for id in ids {
          self.socket.off(id: id)
        }
      }
    }
  }
}
