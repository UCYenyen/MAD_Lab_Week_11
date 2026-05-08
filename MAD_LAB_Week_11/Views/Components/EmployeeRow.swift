import SwiftUI
import SwiftData

struct EmployeeRow: View {
    let employee: Employee
    let viewModel: EmployeeViewModel

    var body: some View {
        HStack(spacing: 12) {
            InitialsAvatar(initials: viewModel.initials(for: employee))
            VStack(alignment: .leading, spacing: 2) {
                Text(employee.name)
                    .font(.headline)
                Text(employee.role)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
            }
            Spacer()
            if viewModel.projectCount(for: employee) > 0 {
                VStack(alignment: .trailing, spacing: 2) {
                    Text("\(viewModel.projectCount(for: employee))")
                        .font(.subheadline.weight(.semibold))
                    Text("Projects")
                        .font(.caption2)
                        .foregroundStyle(.secondary)
                }
            }
        }
        .padding(12)
        .background(.background)
        .clipShape(RoundedRectangle(cornerRadius: 14))
        .shadow(color: .black.opacity(0.05), radius: 4, y: 2)
    }
}
