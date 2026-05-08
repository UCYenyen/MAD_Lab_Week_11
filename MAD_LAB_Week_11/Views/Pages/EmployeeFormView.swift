import SwiftUI
import SwiftData

struct EmployeeFormView: View {
    @Environment(\.modelContext) private var context
    @Environment(\.dismiss) private var dismiss

    let company: Company
    var employee: Employee?

    @State private var viewModel = EmployeeViewModel()
    @State private var name: String = ""
    @State private var role: String = ""

    private var isEditing: Bool { employee != nil }
    private var canSave: Bool {
        !name.trimmingCharacters(in: .whitespaces).isEmpty &&
        !role.trimmingCharacters(in: .whitespaces).isEmpty
    }

    var body: some View {
        NavigationStack {
            Form {
                Section("Employee Information") {
                    TextField("Name", text: $name)
                    TextField("Role", text: $role)
                }
            }
            .navigationTitle(isEditing ? "Edit Employee" : "New Employee")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button { dismiss() } label: {
                        Image(systemName: "xmark")
                    }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button { save() } label: {
                        Image(systemName: "checkmark")
                    }
                    .disabled(!canSave)
                }
            }
            .onAppear {
                viewModel.modelContext = context
                if let employee {
                    name = employee.name
                    role = employee.role
                }
            }
        }
    }

    private func save() {
        if let employee {
            viewModel.updateEmployee(employee, name: name, role: role)
        } else {
            viewModel.addEmployee(name: name, role: role, to: company)
        }
        dismiss()
    }
}
