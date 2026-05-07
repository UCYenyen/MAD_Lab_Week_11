import SwiftUI
import SwiftData

@main
struct MAD_LAB_Week_11App: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: [Company.self, Project.self, Employee.self])
    }
}
