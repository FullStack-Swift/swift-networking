import Foundation

// MARK: Dictionary
internal extension Dictionary {
  func toData() -> Data? {
    do {
      return try JSONSerialization.data(withJSONObject: self, options: [])
    } catch {
      return nil
    }
  }

  func toModel<D>(_ type: D.Type, using decoder: JSONDecoder? = nil) -> D? where D : Decodable {
    toData()?.toModel(type, using: decoder)
  }

  func toString(using: String.Encoding = .utf8) -> String? {
    guard let data = self.toData() else {return nil}
    return String(data: data, encoding: using)
  }
}

// MARK: Encodable
internal extension Encodable {
  func toData(using encoder: JSONEncoder? = nil) -> Data? {
    let encoder = encoder ?? JSONEncoder()
    return try? encoder.encode(self)
  }

  func toDictionary(using encoder: JSONEncoder? = nil) -> [String: Any]? {
    toData(using: encoder)?.toDictionary()
  }

  func toModel<D>(_ type: D.Type, using encoder: JSONEncoder? = nil) -> D? where D: Decodable {
    toData(using: encoder)?.toModel(type)
  }
}

  // MARK: Data
internal extension Data {
  func toString(encoding: String.Encoding = .utf8) -> String? {
    String(data: self, encoding: encoding)
  }

  func toModel<D>(_ type: D.Type, using decoder: JSONDecoder? = nil) -> D? where D: Decodable {
    let decoder = decoder ?? JSONDecoder()
    return try? decoder.decode(type, from: self)
  }

  func toDictionary() -> [String: Any]? {
    do {
      let json = try JSONSerialization.jsonObject(with: self)
      return json as? [String: Any]
    } catch {
      return nil
    }
  }

#if os(iOS)
  func toData(keyPath: String? = nil) -> Self {
    guard let keyPath = keyPath else {
      return self
    }
    do {
      let json = try JSONSerialization.jsonObject(with: self, options: [])
      if let nestedJson = (json as AnyObject).value(forKeyPath: keyPath) {
        guard JSONSerialization.isValidJSONObject(nestedJson) else {
          return self
        }
        let data = try JSONSerialization.data(withJSONObject: nestedJson)
        return data
      }
    } catch {
      return self
    }
    return self
  }
#endif
}

  // MARK: String
internal extension String {
  func toData(using:String.Encoding = .utf8) -> Data? {
    return self.data(using: using)
  }

  func toModel<D>(_ type: D.Type, using decoder: JSONDecoder? = nil) -> D? where D : Decodable {
    return self.toData()?.toModel(type,using: decoder)
  }

  func toDictionary() -> [String: Any]? {
    guard let data = self.toData() else {return nil}
    do {
      return try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
    } catch {
      return nil
    }
  }
}
