
import SwiftUI

struct UserView: View {
    @StateObject private var viewModel = UserViewModel()
    
    var body: some View {
        VStack(spacing: 20) {
            TextField("Name", text: $viewModel.user.name)
                .padding()
                .background(Color(.systemGray6))
                .clipShape(RoundedRectangle(cornerRadius: 8))
            TextField("Email", text: $viewModel.user.email)
                .padding()
                .background(Color(.systemGray6))
                .clipShape(RoundedRectangle(cornerRadius: 8))
                .keyboardType(.emailAddress)
                .textInputAutocapitalization(.none)
            
            if let errorMessage = viewModel.errorMessage {
                Text(errorMessage)
                    .foregroundStyle(.red)
            }
            
            Button(action: {
                viewModel.updateUser(name: viewModel.user.name, email: viewModel.user.email)
            }, label: {
                Text("Update User")
                    .foregroundStyle(.white)
                    .padding()
                    .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
                    .background(.blue)
                    .clipShape(RoundedRectangle(cornerRadius: 8))
            })
        }
        .padding()
        .navigationTitle("User Information")
    }
}

#Preview {
    UserView()
}
