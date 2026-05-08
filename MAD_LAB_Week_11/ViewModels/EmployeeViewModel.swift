import Foundation
import SwiftData

@Observable
final class EmployeeViewModel {
    var modelContext: ModelContext?
    var errorMessage: String?

    init(modelContext: ModelContext? = nil) {
        self.modelContext = modelContext
    }

    func getSortedEmployees(for company: Company) -> [Employee] {
        company.employees.sorted { $0.createdAt < $1.createdAt }
    }

    func sortedByName(for company: Company) -> [Employee] {
        company.employees.sorted { $0.name < $1.name }
    }

    func projectCount(for employee: Employee) -> Int {
        employee.projects.count
    }

    func initials(for employee: Employee) -> String {
        let parts = employee.name.split(separator: " ")
        let letters = parts.prefix(2).compactMap { $0.first }
        return String(letters).uppercased()
    }

    func addEmployee(name: String, role: String, to company: Company) {
        guard let modelContext else { return }
        let employee = Employee(name: name, role: role)
        employee.company = company

        modelContext.insert(employee)
        saveContext()
    }

    func updateEmployee(_ employee: Employee, name: String, role: String) {
        employee.name = name
        employee.role = role
        saveContext()
    }

    func deleteEmployee(_ employee: Employee) {
        guard let modelContext else { return }
        modelContext.delete(employee)
        saveContext()
    }

    private func saveContext() {
        guard let modelContext else { return }
        do {
            try modelContext.save()
        } catch {
            errorMessage = "Failed to save: \(error.localizedDescription)"
        }
    }
}
