import Foundation
import SwiftData

@Model
final class Project {
    var name: String
    var detail: String
    var startDate: Date
    var endDate: Date
    var createdAt: Date

    var company: Company?
    var personInCharge: Employee?

    init(name: String, detail: String, startDate: Date, endDate: Date) {
        self.name = name
        self.detail = detail
        self.startDate = startDate
        self.endDate = endDate
        self.createdAt = Date()
    }

    var isActive: Bool {
        Date() < endDate
    }
}
