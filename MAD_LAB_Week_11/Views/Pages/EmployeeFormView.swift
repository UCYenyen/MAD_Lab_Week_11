import SwiftUI
import SwiftData

struct EmployeeFormView: View {
    @Environment(\.modelContext) private var context
    @Environment(\.dismiss) private var dismiss

    let company: Company
    var employee: Employee?

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
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button { dismiss() } label: {
                        Image(systemName: "xmark")
                    }
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Button { save() } label: {
                        Image(systemName: "checkmark")
                    }
                    .disabled(!canSave)
                }
            }
            .onAppear {
                if let employee {
                    name = employee.name
                    role = employee.role
                }
            }
        }
    }

    private func save() {
        if let employee {
            employee.name = name
            employee.role = role
        } else {
            let newEmployee = Employee(name: name, role: role)
            newEmployee.company = company
            context.insert(newEmployee)
        }
        try? context.save()
        dismiss()
    }
}
