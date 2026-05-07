import SwiftUI
import SwiftData

struct ContentView: View {
    var body: some View {
        NavigationStack {
            CompaniesView()
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(for: [Company.self, Project.self, Employee.self], inMemory: true)
}
