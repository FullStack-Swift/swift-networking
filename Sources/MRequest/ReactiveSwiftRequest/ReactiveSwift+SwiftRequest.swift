import Alamofire
import SwiftRequest
import ReactiveSwift
import Foundation

  // MARK: - ReactiveSwift
extension SwiftRequest: SignalProducerProtocol, SignalProducerConvertible {
  public var producer: SignalProducer<AFDataResponse<Data?>, Never> {
    publisher()
  }
}

  // MARK: - publisher
extension SwiftRequest {
  public func publisher() -> SignalProducer<AFDataResponse<Data?>, Never> {
    dataRequest.reactive.response()
  }
}
