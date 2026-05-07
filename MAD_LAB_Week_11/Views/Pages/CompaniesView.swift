import SwiftUI
import SwiftData

struct CompaniesView: View {
    @Environment(\.modelContext) private var context
    @Query(sort: \Company.createdAt, order: .forward) private var companies: [Company]

    @State private var showForm = false
    @State private var editing: Company?

    var body: some View {
        ZStack {
            Color(.systemGroupedBackground).ignoresSafeArea()
            ScrollView {
                LazyVStack(spacing: 12) {
                    ForEach(companies) { company in
                        NavigationLink(value: company) {
                            CompanyCard(company: company)
                        }
                        .buttonStyle(.plain)
                        .contextMenu {
                            Button {
                                editing = company
                            } label: {
                                Label("Update", systemImage: "checkmark")
                            }
                            Button(role: .destructive) {
                                context.delete(company)
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
        .navigationTitle("Companies")
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button { showForm = true } label: {
                    Image(systemName: "plus")
                }
            }
        }
        .navigationDestination(for: Company.self) { company in
            CompanyDetailView(company: company)
        }
        .sheet(isPresented: $showForm) {
            CompanyFormView()
        }
        .sheet(item: $editing) { company in
            CompanyFormView(company: company)
        }
    }
}
