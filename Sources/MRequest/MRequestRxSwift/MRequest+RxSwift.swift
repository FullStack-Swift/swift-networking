import Foundation
import RxSwift

// MARK: - RxSwift
extension MRequest: ObservableType {
  public typealias Element = AFDataResponse<Data?>
  public func subscribe<Observer>(
    _ observer: Observer
  ) -> Disposable where Observer : ObserverType, Element == Observer.Element {
    publisher().asObservable().subscribe(observer)
  }
}

extension MRequest: ObserverType {
  public func on(_ event: Event<AFDataResponse<Data?>>) {
    
  }
}

  // MARK: - publisher
extension MRequest {
  public func publisher() -> Single<AFDataResponse<Data?>> {
    dataRequest.rx.response()
  }
}
