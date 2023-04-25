import Foundation

// MARK: MUploadRequest
final public class MUploadRequest {
  public var configuration: URLSessionConfiguration?
  public var urlRequest: URLRequest
  public var parameter: RequestProtocol
  internal var storeUploadRequest: UploadRequest!

  @discardableResult
  public init(
    urlRequest: URLRequest? = nil,
    configuration: URLSessionConfiguration? = nil,
    @RequestBuilder builder: () -> RequestProtocol
  ) {
    self.configuration = configuration
    self.urlRequest = urlRequest ?? URLRequest(url: URL(string: "https://")!)
    self.parameter = builder()
    parameter.build(request: &self.urlRequest)
    _ = uploadRequest
  }
}

extension MUploadRequest {
  var uploadRequest: UploadRequest {
    if storeUploadRequest == nil {
      if let configuration {
        let session = Session(configuration: configuration)
        self.storeUploadRequest = session.upload(Data(), with: urlRequest)
      } else {
        self.storeUploadRequest = AF.upload(Data(), with: urlRequest)
      }
    }
    return storeUploadRequest
  }
}

// MARK: CURL Description
public extension MUploadRequest {
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
    uploadRequest
      .cURLDescription(calling: { value in
        let value = value.dropFirst(2)
        Swift.print("⚠️ cURLDescription [[\(sourceFileName(filePath: filename))]:\(line) \(funcName)]")
        Swift.print(value)
      })
    return self
  }

  func cURLDescription(_ cURL: @escaping(String) -> Void) -> Self {
    uploadRequest
      .cURLDescription(calling: cURL)
    return self
  }
}

/// Value used to `await` a `DataResponse` and associated values.
@available(macOS 10.15, iOS 13, tvOS 13, watchOS 6, *)
public extension MUploadRequest {
  // MARK: - serializingResponse
  func serializingResponse<Serializer: ResponseSerializer>(
    using serializer: Serializer,
    automaticallyCancelling shouldAutomaticallyCancel: Bool = false
  ) -> DataTask<Serializer.SerializedObject> {
    uploadRequest
      .serializingResponse(
        using: serializer,
        automaticallyCancelling: shouldAutomaticallyCancel
      )
  }

  func serializingResponse<Serializer: DataResponseSerializerProtocol>(
    using serializer: Serializer,
    automaticallyCancelling shouldAutomaticallyCancel: Bool = false
  ) -> DataTask<Serializer.SerializedObject> {
    uploadRequest
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
    uploadRequest.serializingDecodable(Value.self)
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
      uploadRequest.serializingData()
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
      uploadRequest.serializingString()
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
