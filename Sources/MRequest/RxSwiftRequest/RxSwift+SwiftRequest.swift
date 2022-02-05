import Alamofire
import SwiftRequest
import RxSwift
import Foundation

// MARK: - RxSwift
extension SwiftRequest: ObservableType {
  public typealias Element = AFDataResponse<Data?>
  public func subscribe<Observer>(
    _ observer: Observer
  ) -> Disposable where Observer : ObserverType, Element == Observer.Element {
    publisher().asObservable().subscribe(observer)
  }
}

extension SwiftRequest: ObserverType {
  public func on(_ event: Event<AFDataResponse<Data?>>) {
    
  }
}

  // MARK: - publisher
extension SwiftRequest {
  public func publisher() -> Single<AFDataResponse<Data?>> {
    dataRequest.rx.response()
  }
}
