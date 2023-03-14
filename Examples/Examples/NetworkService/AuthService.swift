import Foundation
import Transform
import MRequest

public class AuthService: BaseService {

  func login(email: String, password: String) -> MRequest {
    MRequest {
      RUrl(urlString: urlString)
        .withPath("v1")
        .withPath("login")
      RHeaders(headers: noAuthHeader)
      RMethod(.post)
      Rbody(["email": email, "password": password].toData())
    }
  }

  func register(email: String, password: String) -> MRequest {
    MRequest {
      RUrl(urlString: urlString)
        .withPath("v1")
        .withPath("register")
      RHeaders(headers: noAuthHeader)
      RMethod(.post)
      Rbody(["email": email, "password": password].toData())
    }
  }
}
