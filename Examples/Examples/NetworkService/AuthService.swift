import Foundation
import Transform
import MRequest

public class AuthService: BaseService {

  func login(email: String, password: String) -> MRequest {
    MRequest {
      RUrl(urlString)
        .withPath("v1")
        .withPath("login")
      RHeaders(noAuthHeader)
      RMethod(.post)
      Rbody(["email": email, "password": password].toData())
    }
  }

  func register(email: String, password: String) -> MRequest {
    MRequest {
      RUrl(urlString)
        .withPath("v1")
        .withPath("register")
      RHeaders(noAuthHeader)
      RMethod(.post)
      Rbody(["email": email, "password": password].toData())
    }
  }
}
