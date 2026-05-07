import SwiftUI
import SwiftData

struct EmployeesView: View {
    @Environment(\.modelContext) private var context
    let company: Company

    @State private var showForm = false
    @State private var editing: Employee?

    private var employees: [Employee] {
        company.employees.sorted { $0.createdAt < $1.createdAt }
    }

    var body: some View {
        ZStack {
            Color(.systemGroupedBackground).ignoresSafeArea()
            ScrollView {
                LazyVStack(spacing: 12) {
                    ForEach(employees) { employee in
                        EmployeeRow(employee: employee)
                            .contextMenu {
                                Button {
                                    editing = employee
                                } label: {
                                    Label("Edit", systemImage: "pencil")
                                }
                                Button(role: .destructive) {
                                    context.delete(employee)
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
    }
}
