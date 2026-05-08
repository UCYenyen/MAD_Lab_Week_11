import SwiftUI
import SwiftData

struct EmployeesView: View {
    @Environment(\.modelContext) private var context
    let company: Company

    @State private var viewModel = EmployeeViewModel()
    @State private var showForm = false
    @State private var editing: Employee?

    var body: some View {
        ZStack {
            Color(.systemGroupedBackground).ignoresSafeArea()
            ScrollView {
                LazyVStack(spacing: 12) {
                    ForEach(viewModel.getSortedEmployees(for: company)) { employee in
                        EmployeeRow(employee: employee, viewModel: viewModel)
                            .contextMenu {
                                Button {
                                    editing = employee
                                } label: {
                                    Label("Edit", systemImage: "pencil")
                                }
                                Button(role: .destructive) {
                                    viewModel.deleteEmployee(employee)
                                } label: {
                                    Label("Delete", systemImage: "trash")
                                }
                            }
                    }
                }
                .padding()
            }
        }
        .navigationTitle("Employees")
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button { showForm = true } label: {
                    Image(systemName: "plus")
                }
            }
        }
        .sheet(isPresented: $showForm) {
            EmployeeFormView(company: company)
        }
        .sheet(item: $editing) { employee in
            EmployeeFormView(company: company, employee: employee)
        }
        .onAppear { viewModel.modelContext = context }
    }
}
