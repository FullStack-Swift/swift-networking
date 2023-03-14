import SwiftUI
import MCombineRequest
import Json

struct ContentView: View {
  
  @State var data = [String]()
  
  var body: some View {
    List {
      Button("Refresh") {
        self.data = []
        request()
      }
      ForEach(data, id: \.self) { item in
        Text(item)
      }
    }
    .padding()
    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
    .onAppear {
      request()
    }
  }
}

extension ContentView {
  func request() {
    Task {
      do {
        let request = MRequest {
          RUrl(urlString: "https://api.publicapis.org/categories")
        }
          .printCURLRequest()
          .cURLDescription { curl in
            let value: String = String(curl.dropFirst(2))
            self.curlRequest(curl: value)
          }
        let value: Data = try await request.data
        self.data = Json(value)[.key("categories")].downcastingOptional([String].self) ?? []
      } catch {
        print(error)
      }
    }
  }
  
  func curlRequest(curl: String) {
    Task {
      do {
        if let curl = MCURLRequest(curl)?.printCURLRequest() {
          let value: Data = try await curl.data
          print(Json(value))
        }
      } catch {
        print(error)
      }
    }
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
