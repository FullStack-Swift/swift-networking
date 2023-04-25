import Foundation
import Combine

/// `MCURLRequest` converts a line of curl command into a `URLRequest` object. It helps
/// you to create HTTP clients for your iOS/macOS/tvOS apps easier once you have
/// a example curl command.
///
/// For example. if you want to fetch a file in JSON format from httpbin.org,
/// you can use only one line of Swift code:
///
/// ``` swift
///let curl = ""
/// if let request = MCURLRequest(curl)?.printCURLRequest() {
///   let value: Data = try await curl.data
/// }
/// ```
@available(macOS 10.15, iOS 13, watchOS 6, tvOS 13, *)
public struct MCURLRequest {
  public var urlRequest: URLRequest
  
  private var cURLData: CURLData
  
  public init?(_ str: String) {
    self.urlRequest = URLRequest(url: URL(string: "https://")!)
    if let result = try? CURLCommands(command: str).cURLData() {
      self.cURLData = result
    } else {
      return nil
    }
  }
  
  public var toMRequest: MRequest {
    MRequest {
      if let urlString = cURLData.url {
        RUrl(urlString: urlString)
      }
      if let httpMethod = cURLData.httpMethod {
        RMethod(HTTPMethod(rawValue: httpMethod))
      }
      if let headers = cURLData.headers {
        RHeaders(headers: HTTPHeaders(headers))
      }
      if let body = cURLData.postData {
        Rbody(body.data(using: .utf8))
      }
      if let queryItems = cURLData.files,!queryItems.isEmpty {
        RQueryItems(queryItems)
      }
    }
  }
}

// MARK: Data Request
@available(macOS 10.15, iOS 13, watchOS 6, tvOS 13, *)
extension MCURLRequest {
  public var dataRequest: DataRequest {
    toMRequest.dataRequest
  }
}

// MARK: CURL Description
@available(macOS 10.15, iOS 13, watchOS 6, tvOS 13, *)
public extension MCURLRequest {
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

/// Value used to `await` a `DataResponse` and associated values.
@available(macOS 10.15, iOS 13, tvOS 13, watchOS 6, *)
public extension MCURLRequest {
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
