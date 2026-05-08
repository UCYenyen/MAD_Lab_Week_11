import Foundation
import SwiftData

@Observable
final class ProjectViewModel {
    var modelContext: ModelContext?
    var errorMessage: String?

    init(modelContext: ModelContext? = nil) {
        self.modelContext = modelContext
    }

    func getSortedProjects(for company: Company) -> [Project] {
        company.projects.sorted { $0.endDate < $1.endDate }
    }

    func isActive(_ project: Project) -> Bool {
        Date() < project.endDate
    }

    func dateRange(_ project: Project) -> String {
        AppDateFormatter.range(project.startDate, project.endDate)
    }

    func addProject(
        name: String,
        detail: String,
        startDate: Date,
        endDate: Date,
        personInCharge: Employee?,
        to company: Company
    ) {
        guard let modelContext else { return }
        let project = Project(
            name: name,
            detail: detail,
            startDate: startDate,
            endDate: endDate
        )
        project.company = company
        project.personInCharge = personInCharge

        modelContext.insert(project)
        saveContext()
    }

    func updateProject(
        _ project: Project,
        name: String,
        detail: String,
        startDate: Date,
        endDate: Date,
        personInCharge: Employee?
    ) {
        project.name = name
        project.detail = detail
        project.startDate = startDate
        project.endDate = endDate
        project.personInCharge = personInCharge

        saveContext()
    }

    func deleteProject(_ project: Project) {
        guard let modelContext else { return }
        modelContext.delete(project)
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
