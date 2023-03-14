import Foundation
import MCombineRequest
import Dependencies

// MARK: Any Dependencies Value define in Here
extension DependencyValues {

  var defaultHeader: HTTPHeaders {
    var headers: HTTPHeaders = []
    headers.add(name: "content-type", value: "application/json")
    if let accessToken {
      headers.add(name: "Authorization", value: "Bearer \(accessToken)")
    }
    return headers
  }

  var authHeader: HTTPHeaders {
    let headers: HTTPHeaders = [
      "content-type": "application/json",
      "Authorization": "Bearer \(accessToken ?? "")"
    ]
    return headers
  }

  var noAuthHeader: HTTPHeaders {

    let headers: HTTPHeaders = [
      "content-type": "application/json"
    ]
    return headers
  }

  var accessToken: String? {
    nil
  }

  var urlString: String {
    ""
  }
}
