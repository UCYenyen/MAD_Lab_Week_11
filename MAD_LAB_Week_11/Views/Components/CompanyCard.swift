import SwiftUI

struct CompanyCard: View {
    let company: Company

    var body: some View {
        HStack(alignment: .top) {
            VStack(alignment: .leading, spacing: 4) {
                Text(company.name)
                    .font(.headline)
                Text(company.address)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                Text("Active Project: \(company.activeProjectCount)")
                    .font(.footnote)
                    .foregroundStyle(.secondary)
                    .padding(.top, 6)
            }
            Spacer()
            HStack(spacing: 4) {
                Text("\(company.employeeCount)")
                    .font(.subheadline.weight(.semibold))
                Image(systemName: "person.fill")
                    .font(.footnote)
            }
        }
        .padding(14)
        .background(Color(.systemBackground))
        .clipShape(RoundedRectangle(cornerRadius: 14))
        .shadow(color: .black.opacity(0.05), radius: 4, y: 2)
    }
}
