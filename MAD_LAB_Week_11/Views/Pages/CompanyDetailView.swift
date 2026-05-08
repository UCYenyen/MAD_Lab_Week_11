import SwiftUI
import SwiftData

struct CompanyDetailView: View {
    @Environment(\.modelContext) private var context
    let company: Company

    @State private var employeeVM = EmployeeViewModel()
    @State private var projectVM = ProjectViewModel()

    var body: some View {
        ZStack {
            Color.white.ignoresSafeArea()
            VStack(spacing: 12) {
                NavigationLink {
                    EmployeesView(company: company)
                } label: {
                    MenuLinkRow(
                        icon: "person.3.fill",
                        iconColor: Color.blue,
                        title: "Employees",
                        count: employeeVM.getSortedEmployees(for: company).count
                    )
                }
                .buttonStyle(.plain)

                NavigationLink {
                    ProjectsView(company: company)
                } label: {
                    MenuLinkRow(
                        icon: "folder.fill",
                        iconColor: Color.green,
                        title: "Projects",
                        count: projectVM.getSortedProjects(for: company).count
                    )
                }
                .buttonStyle(.plain)

                Spacer()
            }
            .padding()
        }
        .navigationTitle(company.name)
        .onAppear {
            employeeVM.modelContext = context
            projectVM.modelContext = context
        }
    }
}
