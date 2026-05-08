import SwiftUI
import SwiftData

struct ProjectFormView: View {
    @Environment(\.modelContext) private var context
    @Environment(\.dismiss) private var dismiss

    let company: Company
    var project: Project?

    @State private var viewModel = ProjectViewModel()
    @State private var employeeVM = EmployeeViewModel()
    @State private var name: String = ""
    @State private var detail: String = ""
    @State private var startDate: Date = Date()
    @State private var endDate: Date = Calendar.current.date(byAdding: .day, value: 1, to: Date()) ?? Date()
    @State private var personInCharge: Employee?
    @State private var showEmployeePicker = false

    private var isEditing: Bool { project != nil }
    private var canSave: Bool {
        !name.trimmingCharacters(in: .whitespaces).isEmpty &&
        !detail.trimmingCharacters(in: .whitespaces).isEmpty &&
        endDate >= startDate
    }

    var body: some View {
        NavigationStack {
            Form {
                Section("Project Information") {
                    TextField("Project Name", text: $name)
                    TextField("Enter project description...", text: $detail, axis: .vertical)
                        .lineLimit(3...6)
                }
                Section {
                    DatePicker("Start Date", selection: $startDate, displayedComponents: .date)
                    DatePicker("End Date", selection: $endDate, in: startDate..., displayedComponents: .date)
                }
                Section("Person In Charge") {
                    Button {
                        showEmployeePicker = true
                    } label: {
                        HStack {
                            Text("Select Employee")
                                .foregroundStyle(.primary)
                            Spacer()
                            Text(personInCharge?.name ?? "None")
                                .foregroundStyle(.secondary)
                            Image(systemName: "chevron.right")
                                .font(.footnote)
                                .foregroundStyle(.secondary)
                        }
                    }
                }
            }
            .navigationTitle(isEditing ? "Edit Project" : "New Project")
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
            .sheet(isPresented: $showEmployeePicker) {
                EmployeePickerView(company: company, viewModel: employeeVM, selected: $personInCharge)
            }
            .onAppear {
                viewModel.modelContext = context
                employeeVM.modelContext = context
                if let project {
                    name = project.name
                    detail = project.detail
                    startDate = project.startDate
                    endDate = project.endDate
                    personInCharge = project.personInCharge
                }
            }
        }
    }

    private func save() {
        if let project {
            viewModel.updateProject(
                project,
                name: name,
                detail: detail,
                startDate: startDate,
                endDate: endDate,
                personInCharge: personInCharge
            )
        } else {
            viewModel.addProject(
                name: name,
                detail: detail,
                startDate: startDate,
                endDate: endDate,
                personInCharge: personInCharge,
                to: company
            )
        }
        dismiss()
    }
}

struct EmployeePickerView: View {
    @Environment(\.dismiss) private var dismiss
    let company: Company
    let viewModel: EmployeeViewModel
    @Binding var selected: Employee?

    var body: some View {
        NavigationStack {
            List {
                Button {
                    selected = nil
                    dismiss()
                } label: {
                    HStack {
                        Text("None")
                        Spacer()
                        if selected == nil {
                            Image(systemName: "checkmark")
                        }
                    }
                }
                ForEach(viewModel.sortedByName(for: company)) { employee in
                    Button {
                        selected = employee
                        dismiss()
                    } label: {
                        HStack {
                            Text(employee.name)
                                .foregroundStyle(.primary)
                            Spacer()
                            if selected?.id == employee.id {
                                Image(systemName: "checkmark")
                            }
                        }
                    }
                }
            }
            .navigationTitle("Select Employee")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Done") { dismiss() }
                }
            }
        }
    }
}
