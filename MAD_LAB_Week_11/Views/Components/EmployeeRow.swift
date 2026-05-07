import SwiftUI

struct EmployeeRow: View {
    let employee: Employee

    var body: some View {
        HStack(spacing: 12) {
            InitialsAvatar(initials: employee.initials)
            VStack(alignment: .leading, spacing: 2) {
                Text(employee.name)
                    .font(.headline)
                Text(employee.role)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
            }
            Spacer()
            if employee.projectCount > 0 {
                VStack(alignment: .trailing, spacing: 2) {
                    Text("\(employee.projectCount)")
                        .font(.subheadline.weight(.semibold))
                    Text("Projects")
                        .font(.caption2)
                        .foregroundStyle(.secondary)
                }
            }
        }
        .padding(12)
        .background(Color(.systemBackground))
        .clipShape(RoundedRectangle(cornerRadius: 14))
        .shadow(color: .black.opacity(0.05), radius: 4, y: 2)
    }
}
