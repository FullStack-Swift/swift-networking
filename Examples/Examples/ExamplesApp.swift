import SwiftUI
import MCombineRequest
import Transform

@main
struct ExamplesApp: App {
  var body: some Scene {
    WindowGroup {
      Text("RT")
        .task {
          Task {
            let data = try await MRequest {
              RUrl("http://127.0.0.1:8080")
                .withPath("todos")
              Rbody(Todo(id: UUID(), text: "_text", isCompleted: false).toData())
              RMethod(.post)
              REncoding(JSONEncoding.default)
            }
              .printCURLRequest()
              .data
          }
        }
    }
  }
}

private struct Todo: Codable, Hashable, Identifiable {
  var id: UUID
  var text: String
  var isCompleted: Bool
}
