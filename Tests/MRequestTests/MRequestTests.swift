import XCTest
import MRequest

final class MRequestTests: XCTestCase {
  
  func testExample() {

  }

  func test_SequenceMany() {
    let sequence = _SequenceMany(requests: [Rbody(["a": "1"])])
    if let rBody = sequence.rBody {
      print(rBody)
    }
  }
}
