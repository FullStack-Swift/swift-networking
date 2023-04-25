import Foundation

public protocol RequestProtocol {
  func build(request: inout URLRequest)
}

extension RequestProtocol {

  public func build(request: URLRequest) {

  }

  public func executing(
    request: inout URLRequest,
    requests: [RequestProtocol]
  ) {
    if requests.isEmpty {
      return
    }
    var items: [RequestProtocol] = []
      /// url
    for item in requests {
      if item is RBaseUrl {
        items.append(item)
      } else if item is RUrl {
        items.append(item)
      }
      if item is RPath {
        items.append(item)
      }
    }
      /// other
    for item in requests {
      if !(item is RUrl || item is REncoding || item is RPath) {
        items.append(item)
      }
    }
      /// encoding
    for item in requests {
      if item is REncoding {
        items.append(item)
      }
    }
      /// build
    items.forEach {
      $0.build(request: &request)
    }
  }
}
