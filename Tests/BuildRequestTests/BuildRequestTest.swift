import XCTest
import BuildRequest

/*
 RBaseUrl
 RUrl
 RPath
 
 Rbody
 RMethod
 REncoding
 
 RHeaders
 RQueryItem
 RQueryItems
 */

final class BuildRequestTest: XCTestCase {
  
  let requests: [RequestProtocol] = [
    RBaseUrl(urlString: "https://test.api.com.rbaseurl"),
    RUrl(urlString: "https://test.api.com.rurl"),
    RPath(path: "json/rpath"),
    
    Rbody(["username": "yourname", "password": "yourpassword"]),
    REncoding(JSONEncoding.default),
    RMethod(.post),
    
    RHeaders(headers: .init(["R1": "RHeaders1", "R2": "RHeaders2", "R3": "RHeaders3"])),
    RQueryItem("key_RQueryItem", value: "value_RQueryItem"),
    RQueryItems(["key_RQueryItems": "value_RQueryItems"]),
  ]
  
  func test_SequenceMany_getRequestWithType() {
    // Given
    let sequence = _SequenceMany(requests: requests)
    // When
    let rBaseUrl = sequence.getRequest(RBaseUrl.self)
    let rUrl = sequence.getRequest(RUrl.self)
    let rPath = sequence.getRequest(RPath.self)
    
    let rBody = sequence.getRequest(Rbody.self)
    let rMethod = sequence.getRequest(RMethod.self)
    let rEndCoding = sequence.getRequest(REncoding.self)
    
    let rHeaders = sequence.getRequest(RHeaders.self)
    let rQueryItem = sequence.getRequest(RQueryItem.self)
    let rQueryItems = sequence.getRequest(RQueryItems.self)
    // Then
    XCTAssertNotNil(rBaseUrl)
    XCTAssertNotNil(rBody)
    XCTAssertNotNil(rMethod)
    
    XCTAssertNotNil(rUrl)
    XCTAssertNotNil(rPath)
    XCTAssertNotNil(rEndCoding)
    
    XCTAssertNotNil(rHeaders)
    XCTAssertNotNil(rQueryItem)
    XCTAssertNotNil(rQueryItems)
  }
  
  func test_SequenceMany_getRequest() {
    // Given
    let sequence = _SequenceMany(requests: requests)
    // When
    let rBaseUrl = sequence.rBaseUrl
    let rUrl = sequence.rUrl
    let rPath = sequence.rPath
    
    let rBody = sequence.rBody
    let rMethod = sequence.rMethod
    let rEndCoding = sequence.rEndCoding
    
    let rHeaders = sequence.rHeaders
    let rQueryItem = sequence.rQueryItem
    let rQueryItems = sequence.rQueryItems
    // Then
    XCTAssertNotNil(rBaseUrl)
    XCTAssertNotNil(rBody)
    XCTAssertNotNil(rMethod)
    
    XCTAssertNotNil(rUrl)
    XCTAssertNotNil(rPath)
    XCTAssertNotNil(rEndCoding)
    
    XCTAssertNotNil(rHeaders)
    XCTAssertNotNil(rQueryItem)
    XCTAssertNotNil(rQueryItems)
  }
  
  func test_SequenceMany_removeRequestWithType() {
    // Given
    var sequence = _SequenceMany(requests: requests)
    
    // RBaseUrl
    XCTAssertNotNil(sequence.getRequest(RBaseUrl.self))
    XCTAssertNotNil(sequence.rBaseUrl)
    sequence.remove(RBaseUrl.self)
    XCTAssertNil(sequence.getRequest(RBaseUrl.self))
    XCTAssertNil(sequence.rBaseUrl)
    
    // RUrl
    XCTAssertNotNil(sequence.getRequest(RUrl.self))
    XCTAssertNotNil(sequence.rUrl)
    sequence.remove(RUrl.self)
    XCTAssertNil(sequence.getRequest(RUrl.self))
    XCTAssertNil(sequence.rUrl)
    
    // RPath
    XCTAssertNotNil(sequence.getRequest(RPath.self))
    XCTAssertNotNil(sequence.rPath)
    sequence.remove(RPath.self)
    XCTAssertNil(sequence.getRequest(RPath.self))
    XCTAssertNil(sequence.rPath)
    
    // Rbody
    XCTAssertNotNil(sequence.getRequest(Rbody.self))
    XCTAssertNotNil(sequence.rBody)
    sequence.remove(Rbody.self)
    XCTAssertNil(sequence.getRequest(Rbody.self))
    XCTAssertNil(sequence.rBody)
    
    // RMethod
    XCTAssertNotNil(sequence.getRequest(RMethod.self))
    XCTAssertNotNil(sequence.rMethod)
    sequence.remove(RMethod.self)
    XCTAssertNil(sequence.getRequest(RMethod.self))
    XCTAssertNil(sequence.rMethod)
    
    // REncoding
    XCTAssertNotNil(sequence.getRequest(REncoding.self))
    XCTAssertNotNil(sequence.rEndCoding)
    sequence.remove(REncoding.self)
    XCTAssertNil(sequence.getRequest(REncoding.self))
    XCTAssertNil(sequence.rEndCoding)
    
    // RHeaders
    XCTAssertNotNil(sequence.getRequest(RHeaders.self))
    XCTAssertNotNil(sequence.rHeaders)
    sequence.remove(RHeaders.self)
    XCTAssertNil(sequence.getRequest(RHeaders.self))
    XCTAssertNil(sequence.rHeaders)
    
    // RQueryItem
    XCTAssertNotNil(sequence.getRequest(RQueryItem.self))
    XCTAssertNotNil(sequence.rQueryItem)
    sequence.remove(RQueryItem.self)
    XCTAssertNil(sequence.getRequest(RQueryItem.self))
    XCTAssertNil(sequence.rQueryItem)
    
    // RQueryItems
    XCTAssertNotNil(sequence.getRequest(RQueryItems.self))
    XCTAssertNotNil(sequence.rQueryItems)
    sequence.remove(RQueryItems.self)
    XCTAssertNil(sequence.getRequest(RQueryItems.self))
    XCTAssertNil(sequence.rQueryItems)
  }
  
  func test_SequenceMany_removeRequest() {
    // Given
    var sequence = _SequenceMany(requests: requests)
    
    // RBaseUrl
    XCTAssertNotNil(sequence.getRequest(RBaseUrl.self))
    XCTAssertNotNil(sequence.rBaseUrl)
    sequence.removeRBaseUrl()
    XCTAssertNil(sequence.getRequest(RBaseUrl.self))
    XCTAssertNil(sequence.rBaseUrl)
    
    // RUrl
    XCTAssertNotNil(sequence.getRequest(RUrl.self))
    XCTAssertNotNil(sequence.rUrl)
    sequence.removeRUrl()
    XCTAssertNil(sequence.getRequest(RUrl.self))
    XCTAssertNil(sequence.rUrl)
    
    // RPath
    XCTAssertNotNil(sequence.getRequest(RPath.self))
    XCTAssertNotNil(sequence.rPath)
    sequence.removeRPath()
    XCTAssertNil(sequence.getRequest(RPath.self))
    XCTAssertNil(sequence.rPath)

    // Rbody
    XCTAssertNotNil(sequence.getRequest(Rbody.self))
    XCTAssertNotNil(sequence.rBody)
    sequence.removeRBody()
    XCTAssertNil(sequence.getRequest(Rbody.self))
    XCTAssertNil(sequence.rBody)
    
    // RMethod
    XCTAssertNotNil(sequence.getRequest(RMethod.self))
    XCTAssertNotNil(sequence.rMethod)
    sequence.removeRMethod()
    XCTAssertNil(sequence.getRequest(RMethod.self))
    XCTAssertNil(sequence.rMethod)
    
    // REncoding
    XCTAssertNotNil(sequence.getRequest(REncoding.self))
    XCTAssertNotNil(sequence.rEndCoding)
    sequence.removeREncoding()
    XCTAssertNil(sequence.getRequest(REncoding.self))
    XCTAssertNil(sequence.rEndCoding)
    
    // RHeaders
    XCTAssertNotNil(sequence.getRequest(RHeaders.self))
    XCTAssertNotNil(sequence.rHeaders)
    sequence.removeRHeaders()
    XCTAssertNil(sequence.getRequest(RHeaders.self))
    XCTAssertNil(sequence.rHeaders)
    
    // RQueryItem
    XCTAssertNotNil(sequence.getRequest(RQueryItem.self))
    XCTAssertNotNil(sequence.rQueryItem)
    sequence.removeRQueryItem()
    XCTAssertNil(sequence.getRequest(RQueryItem.self))
    XCTAssertNil(sequence.rQueryItem)
    
    // RQueryItems
    XCTAssertNotNil(sequence.getRequest(RQueryItems.self))
    XCTAssertNotNil(sequence.rQueryItems)
    sequence.removeRQueryItems()
    XCTAssertNil(sequence.getRequest(RQueryItems.self))
    XCTAssertNil(sequence.rQueryItems)
  }
  
  func test_description() {
    // Given
    let sequence = _SequenceMany(requests: requests)
    print(sequence)
  }
}
