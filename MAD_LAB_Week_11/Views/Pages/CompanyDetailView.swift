import SwiftUI
import SwiftData

struct CompanyDetailView: View {
    let company: Company

    var body: some View {
        ZStack {
            Color(.systemGroupedBackground).ignoresSafeArea()
            VStack(spacing: 12) {
                NavigationLink {
                    EmployeesView(company: company)
                } label: {
                    MenuLinkRow(
                        icon: "person.3.fill",
                        iconColor: .blue,
                        title: "Employees",
                        count: company.employees.count
                    )
                }
                .buttonStyle(.plain)

                NavigationLink {
                    ProjectsView(company: company)
                } label: {
                    MenuLinkRow(
                        icon: "folder.fill",
                        iconColor: .green,
                        title: "Projects",
                        count: company.projects.count
                    )
                }
                .buttonStyle(.plain)

                Spacer()
            }
            .padding()
        }
        .navigationTitle(company.name)
        .navigationBarTitleDisplayMode(.inline)
    }
}
