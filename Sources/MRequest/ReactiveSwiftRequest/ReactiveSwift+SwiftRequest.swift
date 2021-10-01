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
    guard let configuration = self.urlSessionConfiguration else {
      return AF.request(urlRequest).reactive.response()
    }
    let session = Session(configuration: configuration)
    return session.request(urlRequest).reactive.response()
  }
}
