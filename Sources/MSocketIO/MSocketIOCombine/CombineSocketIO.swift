import Foundation
import Combine

@available(macOS 10.15, iOS 13, watchOS 6, tvOS 13, *)
public extension MSocketIO {
  func on(_ event: String) -> AnyPublisher<[String: Any], Never> {
    let passthroughSubject = PassthroughSubject<[String: Any], Never>()
    socket.on(event) { (data, ack) in
      if let dict = data.first as? [String: Any] {
        passthroughSubject.send(dict)
      }
    }
    return passthroughSubject.eraseToAnyPublisher()
  }
  
  func onAnyEvent() -> AnyPublisher<SocketAnyEvent, Never> {
    let passthroughSubject = PassthroughSubject<SocketAnyEvent, Never>()
    socket.onAny() { anyEvent in
      passthroughSubject.send(anyEvent)
    }
    return passthroughSubject.eraseToAnyPublisher()
  }
  
  func on(clientEvents: [SocketClientEvent]) -> AnyPublisher<SocketClientEvent, Never> {
    let passthroughSubject = PassthroughSubject<SocketClientEvent, Never>()
    var ids = [UUID]()
    for event in SocketClientEvent.allCases where clientEvents.contains(event) {
      let id = socket.on(clientEvent: event) { _, _ in
        passthroughSubject.send(event)
      }
      ids.append(id)
    }
    return passthroughSubject.handleEvents(receiveCompletion: { [weak self] _ in
      guard let self else { return }
      for id in ids {
        self.socket.off(id: id)
      }
    })
    .eraseToAnyPublisher()
  }
}
