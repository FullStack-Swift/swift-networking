import BuildRequest
import Foundation

public typealias MSocket = SwiftWebSocket

final public class SwiftWebSocket {
  public var socket: WebSocket?
  public var isForceDisconnect: Bool = false
  public var urlRequest: URLRequest
  public var parameter: RequestBuilderProtocol
  
  public init(urlRequest: URLRequest? = nil,
              @RequestBuilder builder: () -> RequestBuilderProtocol) {
    self.urlRequest = urlRequest ?? URLRequest(url: URL(string: "https://")!)
    self.parameter = builder()
    parameter.build(request: &self.urlRequest)
    socket = WebSocket(request: self.urlRequest)
    socket?.connect()
  }
  
  deinit {
    if isForceDisconnect {
      socket?.forceDisconnect()
    } else {
      socket?.disconnect()
    }
  }
  
  func write(string: String?, completion: (() -> ())? = nil) {
    if let string = string {
      socket?.write(string: string, completion: completion)
    }
  }
  
  func write(data: Data?, completion: (() -> ())? = nil) {
    if let data = data {
      socket?.write(data: data, completion: completion)
    }
  }
}
