import Foundation
import SwiftData

@Model
final class Employee {
    var name: String
    var role: String
    var createdAt: Date

    var company: Company?

    @Relationship(deleteRule: .nullify, inverse: \Project.personInCharge)
    var projects: [Project] = []

    init(name: String, role: String) {
        self.name = name
        self.role = role
        self.createdAt = Date()
    }
}
