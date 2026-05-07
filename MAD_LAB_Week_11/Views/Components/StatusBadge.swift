import SwiftUI

struct StatusBadge: View {
    let isActive: Bool

    var body: some View {
        Text(isActive ? "Active" : "Completed")
            .font(.caption2.weight(.semibold))
            .padding(.horizontal, 8)
            .padding(.vertical, 4)
            .background(isActive ? Color.green.opacity(0.18) : Color.gray.opacity(0.18))
            .foregroundStyle(isActive ? Color.green : Color.gray)
            .clipShape(Capsule())
    }
}
