#  Service

## Base API service

```swift

open class BaseAPIService {
  // some properties in here
}

```

```swift

final public class AuthService: BaseAPIService {
  
  func login(email: String,password: String) -> MRequest {
    MRequest {
      RMethod(.post)
      RUrl(urlString: urlString)
      //...
    }
  }
  
  func login(email: password) -> MRequest {
    MRequest {
      RMethod(.post)
      RUrl(urlString: urlString)
      //...
    }
  }

}

```


