import Foundation
import SwiftData

@Observable
final class CompanyViewModel {
    var modelContext: ModelContext?
    var errorMessage: String?

    init(modelContext: ModelContext? = nil) {
        self.modelContext = modelContext
    }

    func employeeCount(for company: Company) -> Int {
        company.employees.count
    }

    func projectCount(for company: Company) -> Int {
        company.projects.count
    }

    func activeProjectCount(for company: Company) -> Int {
        company.projects.filter { Date() < $0.endDate }.count
    }

    func addCompany(name: String, address: String) {
        guard let modelContext else { return }
        let company = Company(name: name, address: address)
        modelContext.insert(company)
        saveContext()
    }

    func updateCompany(_ company: Company, name: String, address: String) {
        company.name = name
        company.address = address
        saveContext()
    }

    func deleteCompany(_ company: Company) {
        guard let modelContext else { return }
        modelContext.delete(company)
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
