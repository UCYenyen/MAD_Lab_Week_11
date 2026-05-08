import SwiftUI

struct ProjectCard: View {
    let project: Project
    let viewModel: ProjectViewModel

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack(alignment: .top) {
                Text(project.name)
                    .font(.headline)
                Spacer()
                StatusBadge(isActive: viewModel.isActive(project))
            }
            Text(project.detail)
                .font(.subheadline)
                .foregroundStyle(.secondary)
                .lineLimit(2)
            HStack(spacing: 6) {
                Image(systemName: "calendar")
                    .font(.footnote)
                Text(viewModel.dateRange(project))
                    .font(.footnote)
            }
            .foregroundStyle(.secondary)
            HStack(spacing: 6) {
                Image(systemName: "person.fill")
                    .font(.footnote)
                Text(project.personInCharge?.name ?? "Unassigned")
                    .font(.footnote)
            }
            .foregroundStyle(.secondary)
        }
        .padding(14)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(.background)
        .clipShape(RoundedRectangle(cornerRadius: 14))
        .shadow(color: .black.opacity(0.05), radius: 4, y: 2)
    }
}
