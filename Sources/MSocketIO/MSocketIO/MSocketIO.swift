import Foundation

final public class MSocketIO {
  
  public var socketManager: SocketManager
  public var socket: SocketIOClient
  private var connectParams: [String: Any]
  private var needsReconnect = false
  
  public init(
    withSourceURL url: URL,
    timeout: TimeInterval = 15,
    connectParams: [String: Any]
  ) {
    self.socketManager = SocketManager(
      socketURL: url,
      config: [.log(true), .compress, .connectParams(connectParams)]
    )
    self.socket = socketManager.defaultSocket
    self.connectParams = connectParams
    self.start()
  }
  
  deinit {
    self.stop()
  }
  
  public func start() {
    socket.connect(timeoutAfter: 2) { [weak self] in
      guard let self else { return }
      self.start()
    }
  }
  
  public func stop() {
    socket.disconnect()
  }
  
  public func emit( event: String, _ items: SocketData..., completion: (() -> ())? = nil) {
    switch socketManager.status {
      case .connected:
        socket.emit(event, items, completion: completion)
        return
      default:
        socket.connect()
        self.emit(event: event, items, completion: completion)
    }
  }
}

extension SocketClientEvent: CaseIterable {
  public static var allCases: [SocketClientEvent] = [
    .connect,
    .disconnect,
    .error,
    .ping,
    .pong,
    .reconnect,
    .reconnectAttempt,
    .statusChange,
    .websocketUpgrade
  ]
}
