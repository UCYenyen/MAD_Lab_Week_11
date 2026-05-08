import Foundation
import SwiftData

@Model
final class Company {
    var name: String
    var address: String
    var createdAt: Date

    @Relationship(deleteRule: .cascade, inverse: \Project.company)
    var projects: [Project] = []

    @Relationship(deleteRule: .cascade, inverse: \Employee.company)
    var employees: [Employee] = []

    init(name: String, address: String) {
        self.name = name
        self.address = address
        self.createdAt = Date()
    }
}
