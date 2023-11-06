import Foundation

public struct Rbody: RequestProtocol {
  
  private var data: Data?
  
  public init(_ data: Data?) {
    self.data = data
  }
  
  public func build(request: inout URLRequest) {
    request.httpBody = data
  }
  
  public var value: Data? {
    data
  }
}

extension Rbody {
  public init(_ string: String?) {
    self.init(string?.toData())
  }
  
  public init(_ initial: () -> String?) {
    self.init(initial())
  }
  
  public init<Key: Hashable, Value>(_ dictionary: Dictionary<Key, Value>) {
    self.init(dictionary.toData())
  }
  
  public init(_ model: Encodable) {
    self.init(model.toData())
  }
}

extension Rbody {
  public var description: String {
    [typeName: data?.toString() ?? "nil"].description
  }
}

extension Rbody {
  public var debugDescription: String {
    description
  }
}
