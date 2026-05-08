import SwiftUI
import SwiftData

struct CompanyFormView: View {
    @Environment(\.modelContext) private var context
    @Environment(\.dismiss) private var dismiss

    var company: Company?

    @State private var viewModel = CompanyViewModel()
    @State private var name: String = ""
    @State private var address: String = ""

    private var isEditing: Bool { company != nil }
    private var canSave: Bool {
        !name.trimmingCharacters(in: .whitespaces).isEmpty &&
        !address.trimmingCharacters(in: .whitespaces).isEmpty
    }

    var body: some View {
        NavigationStack {
            VStack(spacing: 12) {
                TextField("Company Name", text: $name)
                    .padding(14)
                    .background(Color.gray.opacity(0.1))
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                TextField("Company Address", text: $address)
                    .padding(14)
                    .background(Color.gray.opacity(0.1))
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                Spacer()
            }
            .padding()
            .background(Color.white)
            .navigationTitle(isEditing ? "Edit Company" : "New Company")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button { dismiss() } label: {
                        Image(systemName: "xmark")
                    }
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Button { save() } label: {
                        Image(systemName: "checkmark")
                    }
                    .disabled(!canSave)
                }
            }
            .onAppear {
                viewModel.modelContext = context
                if let company {
                    name = company.name
                    address = company.address
                }
            }
        }
    }

    private func save() {
        if let company {
            viewModel.updateCompany(company, name: name, address: address)
        } else {
            viewModel.addCompany(name: name, address: address)
        }
        dismiss()
    }
}
