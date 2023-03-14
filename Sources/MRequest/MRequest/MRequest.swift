import Foundation

// MARK: - Core Request
final public class MRequest {
  public var configuration: URLSessionConfiguration?
  public var urlRequest: URLRequest
  public var parameter: RequestBuilderProtocol
  internal var storeDataRequest: DataRequest!
  
  @discardableResult
  public init(
    urlRequest: URLRequest? = nil,
    configuration: URLSessionConfiguration? = nil,
    @RequestBuilder builder: () -> RequestBuilderProtocol
  ) {
    self.configuration = configuration
    self.urlRequest = urlRequest ?? URLRequest(url: URL(string: "https://")!)
    self.parameter = builder()
    parameter.build(request: &self.urlRequest)
    _ = dataRequest
  }
}

// MARK: Data Request
public extension MRequest {
  var dataRequest: DataRequest {
    if storeDataRequest == nil {
      if let configuration {
        let session = Session(configuration: configuration)
        self.storeDataRequest = session.request(urlRequest)
      } else {
        self.storeDataRequest = AF.request(urlRequest)
      }
    }
    return storeDataRequest
  }
}

// MARK: CURL Description
public extension MRequest {
  func printCURLRequest(
    filename: String = #file,
    line: Int = #line,
    funcName: String = #function
  ) -> Self {
    func sourceFileName(filePath: String) -> String {
      let components = filePath.components(separatedBy: "/")
      if let componentLast = components.last {
        return componentLast
      } else {
        return ""
      }
    }
    dataRequest
      .cURLDescription(calling: { value in
        let value = value.dropFirst(2)
        Swift.print("⚠️ cURLDescription [[\(sourceFileName(filePath: filename))]:\(line) \(funcName)]")
        Swift.print(value)
      })
    return self
  }
  
  func cURLDescription(_ cURL: @escaping(String) -> Void) -> Self {
    dataRequest
      .cURLDescription(calling: cURL)
    return self
  }
}

// MARK: Configuration DataRequest
public extension MRequest {
  func withDataRequest(_ block: (inout DataRequest) -> Void) -> Self {
    block(&storeDataRequest)
    return self
  }
}

/// Value used to `await` a `DataResponse` and associated values.
@available(macOS 10.15, iOS 13, tvOS 13, watchOS 6, *)
public extension MRequest {
  // MARK: - serializingResponse
  func serializingResponse<Serializer: ResponseSerializer>(
    using serializer: Serializer,
    automaticallyCancelling shouldAutomaticallyCancel: Bool = false
  ) -> DataTask<Serializer.SerializedObject> {
    dataRequest
      .serializingResponse(
        using: serializer,
        automaticallyCancelling: shouldAutomaticallyCancel
      )
  }
  
  func serializingResponse<Serializer: DataResponseSerializerProtocol>(
    using serializer: Serializer,
    automaticallyCancelling shouldAutomaticallyCancel: Bool = false
  ) -> DataTask<Serializer.SerializedObject> {
    dataRequest
      .serializingResponse(
        using: serializer,
        automaticallyCancelling: shouldAutomaticallyCancel
      )
  }
  
  // MARK: - Response
  func response<Serializer: ResponseSerializer>(
    using serializer: Serializer,
    automaticallyCancelling shouldAutomaticallyCancel: Bool = false
  ) async -> DataResponse<Serializer.SerializedObject, AFError> {
    await serializingResponse(
      using: serializer,
      automaticallyCancelling: shouldAutomaticallyCancel
    )
    .response
  }
  
  func response<Serializer: DataResponseSerializerProtocol>(
    using serializer: Serializer,
    automaticallyCancelling shouldAutomaticallyCancel: Bool = false
  ) async -> DataResponse<Serializer.SerializedObject, AFError> {
    await serializingResponse(
      using: serializer,
      automaticallyCancelling: shouldAutomaticallyCancel
    )
    .response
  }
  
  // MARK: - Result
  func result<Serializer: ResponseSerializer>(
    using serializer: Serializer,
    automaticallyCancelling shouldAutomaticallyCancel: Bool = false
  ) async -> Result<Serializer.SerializedObject, AFError> {
    await serializingResponse(
      using: serializer,
      automaticallyCancelling: shouldAutomaticallyCancel
    )
    .result
  }
  
  func result<Serializer: DataResponseSerializerProtocol>(
    using serializer: Serializer,
    automaticallyCancelling shouldAutomaticallyCancel: Bool = false
  ) async -> Result<Serializer.SerializedObject, AFError> {
    await serializingResponse(
      using: serializer,
      automaticallyCancelling: shouldAutomaticallyCancel
    )
    .result
  }
  
  // MARK: - Decodeabe
  func serializingDecodeable<Value: Decodable>(
    _ type: Value.Type = Value.self
  ) async -> DataTask<Value> {
    dataRequest.serializingDecodable(Value.self)
  }
  
  func resultDecodeable<Value: Decodable>(
    _ type: Value.Type = Value.self
  ) async -> Result<Value, AFError> {
    await serializingDecodeable(Value.self).result
  }

  func decodeable<Value: Decodable>(_ type: Value.Type = Value.self) async throws -> Value {
    try await serializingDecodeable(Value.self).value
  }
  
  // MARK: - Data
  var serializingData: DataTask<Data> {
    get async {
      dataRequest.serializingData()
    }
  }
  
  func resultData() async -> Result<Data, AFError> {
    await serializingData.result
  }
  
  var data: Data {
    get async throws {
      return try await serializingData.value
    }
  }
  
  // MARK: - String
  var serializingString: DataTask<String> {
    get async {
      dataRequest.serializingString()
    }
  }
  
  func resultString() async -> Result<String, AFError> {
    await serializingString.result
  }
  
  var string: String {
    get async throws {
      return try await serializingString.value
    }
  }
}
