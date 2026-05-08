import SwiftUI
import SwiftData

struct ProjectsView: View {
    @Environment(\.modelContext) private var context
    let company: Company

    @State private var viewModel = ProjectViewModel()
    @State private var showForm = false
    @State private var editing: Project?

    var body: some View {
        ZStack {
            Color(.systemGroupedBackground).ignoresSafeArea()
            ScrollView {
                LazyVStack(spacing: 12) {
                    ForEach(viewModel.getSortedProjects(for: company)) { project in
                        ProjectCard(project: project, viewModel: viewModel)
                            .contextMenu {
                                Button {
                                    editing = project
                                } label: {
                                    Label("Update", systemImage: "checkmark")
                                }
                                Button(role: .destructive) {
                                    viewModel.deleteProject(project)
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
        .onAppear { viewModel.modelContext = context }
    }
}
