import Foundation
import ReactiveSwift

  // MARK: - ReactiveSwift
extension MRequest: SignalProducerProtocol, SignalProducerConvertible {
  public var producer: SignalProducer<AFDataResponse<Data?>, Never> {
    publisher()
  }
}

  // MARK: - publisher
extension MRequest {
  public func publisher() -> SignalProducer<AFDataResponse<Data?>, Never> {
    dataRequest.reactive.response()
  }
}
