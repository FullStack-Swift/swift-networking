import Foundation

internal protocol PrototypeProtocol {}

internal extension PrototypeProtocol {
  func with(_ block: (inout Self) -> Void) -> Self {
    var clone = self
    block(&clone)
    return clone
  }
}

internal struct CURLData: PrototypeProtocol {
  var url: String?
  var user: String?
  var password: String?
  var postData: String?
  var headers: [String: String]?
  var postFields: [String: String]?
  var files: [String: String]?
  var httpMethod: String?
}

internal enum CRLDataType {
  case url(String)
  case data(String)
  case form(_ key: String, _ value: String)
  case header(_ key: String, _ value: String)
  case referer(String)
  case userAgent(String)
  case user(_ user: String, _ password: String?)
  case requestMethod(String)
}

internal enum CURLError: Error, LocalizedError {
  case invalidBegin
  case noURL
  case invalidURL(String)
  case noSuchOption(String)
  case inValidParameter(String)
  case otherSyntaxError
}

@available(macOS 10.15, iOS 13, watchOS 6, tvOS 13, *)
internal struct CURLCommands {
  internal private(set) var command: String
  
  internal init(command: String) {
    self.command = command
  }
  
  internal func cURLData() throws -> CURLData {
    let command = command.trimmingCharacters(in: CharacterSet.whitespaces)
    let slices = HandlerCommands.slicesCommand(command)
    let options = try HandlerCommands.transformToCRLDataType(slices)
    return try HandlerCommands.transformToCURLData(options)
  }
}

@available(macOS 10.15, iOS 13, watchOS 6, tvOS 13, *)
internal struct HandlerCommands {
  static func slicesCommand(_ str: String) -> [String] {
    let str = str.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
    print(str)
    var slices = [String]()
    let scanner = Scanner(string: str)
    scanner.charactersToBeSkipped = nil
    var buffer = ""
    
    while scanner.isAtEnd == false {
      let result = scanner.scanUpToCharacters(from: CharacterSet(charactersIn: " \n\"\'") )
      if result == nil {
        scanner.currentIndex = str.index(after: scanner.currentIndex)
      }
      if scanner.isAtEnd {
        buffer += result ?? ""
        slices.append(buffer)
        break
      }
      
      let lastChar = String(str[scanner.currentIndex])
      if lastChar == "\"" || lastChar == "\'" {
        let quote = lastChar
        buffer += result ?? ""
        scanner.currentIndex = str.index(after: scanner.currentIndex)
        while true {
          if let scannedString = scanner.scanUpToString(quote) {
            buffer.append(scannedString)
            if scanner.isAtEnd {
              if !buffer.isEmpty {
                slices.append(buffer)
              }
              buffer = ""
              break
            }
            if scannedString[scannedString.index(before: scannedString.endIndex)] != "\\" {
              // Find matching quote mark.
              scanner.currentIndex = str.index(after: scanner.currentIndex)
              if let _ = scanner.scanCharacters(from: CharacterSet(charactersIn: " \n") ) {
                if !buffer.isEmpty {
                  slices.append(buffer)
                  buffer = ""
                }
              }
              break
            } else {
              // The quote mark is escaped. Continue.
              scanner.currentIndex = str.index(after: scanner.currentIndex)
              buffer.remove(at: buffer.index(before: buffer.endIndex))
              buffer.append(quote)
            }
          } else {
            if !buffer.isEmpty {
              slices.append(buffer)
              buffer = ""
            }
            break
          }
        }
        if scanner.isAtEnd {
          if !buffer.isEmpty {
            slices.append(buffer)
            buffer = ""
          }
          break
        }
      } else {
        buffer += result ?? ""
        if !buffer.isEmpty {
          slices.append(buffer)
        }
        buffer = ""
      }
    }
    return slices
  }
  
  static func transformToCRLDataType(_ tokens: [String]) throws -> [CRLDataType] {
    switch tokens.first {
      case "curl": break
      default: throw CURLError.invalidBegin
    }
    if tokens.count < 2 {
      throw CURLError.noURL
    }
    var options = [CRLDataType]()
    var index = 1
    while index < tokens.count {
      let token = tokens[index]
      if token.hasPrefix("--") {
        try handleLongCommands(token, &options)
      }
      else if token.hasPrefix("-") {
        index += 1
        if index >= tokens.count {
          throw CURLError.inValidParameter(token)
        }
        try handleShortCommands(tokens, index, token, &options)
      }  else {
        options.append(.url(token))
      }
      index += 1
    }
    return options
  }
  
  
  fileprivate static func handleShortCommands(_ tokens: [String], _ index: Int, _ token: String, _ options: inout [CRLDataType]) throws {
    let nextToken = tokens[index]
    switch token {
      case "-d":
        options.append(.data(nextToken))
      case "-F":
        let components = nextToken.components(separatedBy: "=")
        if components.count < 2 {
          throw CURLError.inValidParameter(token)
        }
        options.append(.form(components[0].trimmingCharacters(in: CharacterSet.whitespacesAndNewlines), components[1]))
      case "-H":
        let components = nextToken.components(separatedBy: ":")
        if components.count > 2 {
          options.append(.header(components[0].trimmingCharacters(in: CharacterSet.whitespacesAndNewlines), components[1].trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)))
        }
      case "-e":
        options.append(.referer(nextToken))
      case "-A":
        options.append(.userAgent(nextToken))
      case "-X":
        options.append(.requestMethod(nextToken))
      case "-u":
        let components = nextToken.components(separatedBy: ":")
        if components.count >= 2 {
          options.append(.user(components[0], components[1]))
        } else {
          options.append(.user(components[0], nil))
        }
      default:
        break
    }
  }
  
  fileprivate static func handleLongCommands(_ token: String, _ options: inout [CRLDataType]) throws {
    let components = token.components(separatedBy: "=")
    switch components[0] {
      case "--data":
        if components.count < 2 {
          throw CURLError.inValidParameter(components[0])
        }
        options.append(.data(components[1]))
      case "--form", "-form-string":
        if components.count < 3 {
          throw CURLError.inValidParameter(components[0])
        }
        options.append(.form(components[1], components[2]))
      case "--header":
        if components.count < 2 {
          throw CURLError.inValidParameter(components[0])
        }
        let keyValue = components[1].components(separatedBy: ":")
        if keyValue.count < 2 {
          throw CURLError.inValidParameter(components[0])
        }
        options.append(.header(keyValue[0].trimmingCharacters(in: CharacterSet.whitespacesAndNewlines), keyValue[1].trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)))
      case "--referer":
        if components.count < 2 {
          throw CURLError.inValidParameter(components[0])
        }
        options.append(.referer(components[1]))
      case "--user-agent":
        if components.count < 2 {
          throw CURLError.inValidParameter(components[0])
        }
        options.append(.userAgent(components[1]))
      case "--request":
        if components.count < 2 {
          throw CURLError.inValidParameter(components[0])
        }
        options.append(.requestMethod(components[1]))
      case "--user":
        if components.count < 2 {
          throw CURLError.inValidParameter(components[0])
        }
        let userPassword = components[1].components(separatedBy: ":")
        if userPassword.count >= 2 {
          options.append(.user(userPassword[0], userPassword[1]))
        } else {
          options.append(.user(userPassword[0], nil))
        }
      default:
        throw CURLError.noSuchOption(components[0])
    }
  }
  
  internal static func transformToCURLData(_ options: [CRLDataType]) throws -> CURLData {
    var url: String = ""
    var user: String?
    var password: String?
    var postData: String?
    var headers: [String: String] = [:]
    var postFields: [String: String] = [:]
    var files: [String: String] = [:]
    var httpMethod: String?
    
    for option in options {
      switch option {
        case .url(let str):
          url = str
        case .data(let data):
          postData = data
        case .form(let key, let value):
          if value.hasPrefix("@") {
            files[key] = value
          } else {
            postFields[key] = value
          }
        case .header(let key, let value):
          headers[key] = value
        case .referer(let str):
          headers["Referer"] = str
        case .userAgent(let str):
          headers["User-Agent"] = str
        case .user(let aUser, let aPassword):
          user = aUser
          password = aPassword
        case .requestMethod(let method):
          httpMethod = method
      }
    }
    
    let lastHttpMethod: String = {
      if let httpMethod = httpMethod {
        return httpMethod
      }
      if postData != nil {
        return "POST"
      }
      if !postFields.isEmpty {
        return "POST"
      }
      if !files.isEmpty {
        return "POST"
      }
      return "GET"
    }()
    
    url = url.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
    if !url.hasPrefix("https://") && !url.hasPrefix("http://") {
      throw CURLError.invalidURL(url)
    }
    do {
      let pattern = "https?://(.*)@(.*)"
      let regex = try NSRegularExpression(pattern: pattern, options: [])
      let matches = regex.matches(in: url, options: [], range: NSMakeRange(0, url.count))
      if matches.count > 0 {
        let usernameRange = matches[0].range(at: 1)
        let start = url.index(url.startIndex, offsetBy: usernameRange.location)
        let end = url.index(url.startIndex, offsetBy: usernameRange.location + usernameRange.length)
        let substring = url[start..<end]
        let components = substring.components(separatedBy: ":")
        if user == nil {
          user = components[0]
          if components.count >= 2 {
            password = components[1]
          }
        }
        url.removeSubrange(start...end)
      }
    }
    
    guard let _ = URL(string: url) else {
      throw CURLError.invalidURL(url)
    }
    
    return CURLData()
      .with {
        $0.url = url
        $0.user = user
        $0.password = password
        $0.postData = postData
        $0.headers = headers
        $0.postFields = postFields
        $0.files = files
        $0.httpMethod = lastHttpMethod
      }
  }
}
