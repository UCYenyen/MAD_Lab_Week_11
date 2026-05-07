import SwiftUI
import SwiftData

struct ProjectsView: View {
    @Environment(\.modelContext) private var context
    let company: Company

    @State private var showForm = false
    @State private var editing: Project?

    private var projects: [Project] {
        company.projects.sorted { $0.endDate < $1.endDate }
    }

    var body: some View {
        ZStack {
            Color(.systemGroupedBackground).ignoresSafeArea()
            ScrollView {
                LazyVStack(spacing: 12) {
                    ForEach(projects) { project in
                        ProjectCard(project: project)
                            .contextMenu {
                                Button {
                                    editing = project
                                } label: {
                                    Label("Update", systemImage: "checkmark")
                                }
                                Button(role: .destructive) {
                                    context.delete(project)
                                    try? context.save()
                                } label: {
                                    Label("Delete", systemImage: "trash")
                                }
                            }
                    }
                }
                .padding()
            }
        }
        .navigationTitle("Projects")
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button { showForm = true } label: {
                    Image(systemName: "plus")
                }
            }
        }
        .sheet(isPresented: $showForm) {
            ProjectFormView(company: company)
        }
        .sheet(item: $editing) { project in
            ProjectFormView(company: company, project: project)
        }
    }
}
