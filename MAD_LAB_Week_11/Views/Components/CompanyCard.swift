import SwiftUI
import SwiftData

struct CompanyCard: View {
    let company: Company
    let viewModel: CompanyViewModel

    var body: some View {
        HStack(alignment: .top) {
            VStack(alignment: .leading, spacing: 4) {
                Text(company.name)
                    .font(.headline)
                Text(company.address)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                Text("Active Project: \(viewModel.activeProjectCount(for: company))")
                    .font(.footnote)
                    .foregroundStyle(.secondary)
                    .padding(.top, 6)
            }
            Spacer()
            HStack(spacing: 4) {
                Text("\(viewModel.employeeCount(for: company))")
                    .font(.subheadline.weight(.semibold))
                Image(systemName: "person.fill")
                    .font(.footnote)
            }
        }
        .padding(14)
        .background(.background)
        .clipShape(RoundedRectangle(cornerRadius: 14))
        .shadow(color: .black.opacity(0.05), radius: 4, y: 2)
    }
}
