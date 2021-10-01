import RxSwift
import SwiftRequest
import SwiftWebSocket
import Foundation

  // MARK: - RxSwift
extension SwiftWebSocket: ObservableType {
  public typealias Element = WebSocketEvent
  public func subscribe<Observer>(_ observer: Observer) -> Disposable where Observer : ObserverType, Element == Observer.Element {
    publisher().asObservable().subscribe(observer)
  }
}

extension SwiftWebSocket: ObserverType {
  public func on(_ event: Event<WebSocketEvent>) {
    switch event {
    case .next:
      break
    case .error:
      break
    case .completed:
      break
    }
  }
}

extension SwiftWebSocket {
  public func publisher() -> Observable<WebSocketEvent> {
    Observable<WebSocketEvent>.create { [weak self] observer in
      guard let self = self else {
        return Disposables.create {
          
        }
      }
      self.socket?.onEvent = { event in
        observer.onNext(event)
      }
      return Disposables.create {
        self.socket?.forceDisconnect()
      }
    }
  }
}
