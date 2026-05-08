import Foundation

enum AppDateFormatter {
    static let short: DateFormatter = {
        let f = DateFormatter()
        f.dateFormat = "d MMM yyyy"
        return f
    }()

    static func format(_ date: Date) -> String {
        short.string(from: date)
    }

    static func range(_ start: Date, _ end: Date) -> String {
        "\(format(start)) - \(format(end))"
    }
}
