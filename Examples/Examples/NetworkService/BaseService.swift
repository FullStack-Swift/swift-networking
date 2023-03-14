import Foundation
import MRequest
import Dependencies

open class BaseService {

  // MARK: DI, define some properties using in sub class
  @Dependency(\.defaultHeader) var defaultHeader
  @Dependency(\.authHeader) var authHeader
  @Dependency(\.noAuthHeader) var noAuthHeader
  @Dependency(\.accessToken) var accessToken
  @Dependency(\.urlString) var urlString

  public init() {

  }

}
