import SwiftUI
import Auth0

struct LoginView: View {
    @EnvironmentObject private var loginController: LoginController
    @Environment(\.presentationMode) private var presentationMode: Binding<PresentationMode>
    @Binding var shouldShowOnboarding: Bool
    @State private var showingAlert = false
    @State private var alertMessage: String = ""

    
    @State var password: String = ""
    @State var email: String = ""

    var body: some View {
        NavigationStack {
            VStack(alignment: .leading) {
                TextFieldWithTitle(title: "login.email".localized, text: $email)
                SecureTextField(title: "login.name".localized, text: $password)
                Button {
                    Auth0
                        .webAuth()
                        .start { result in
                            switch result {
                            case .success(let credentials):
                                print("Obtained credentials: \(credentials)")
                                shouldShowOnboarding.toggle()
                            case .failure(let error):
                                print("Failed with: \(error)")
                            }
                        }
                    /* // check if credentials exist
                    if !loginController.doCredentialsExist(email: email, password: password) {
                        alertMessage = "login.alert.doesntexist".localized
                        showingAlert = true
                        shouldShowOnboarding.toggle()
                        presentationMode.wrappedValue.dismiss()
                    }
                     */
                } label: {
                    RoundedButton(title: "login.title".localized, width: .infinity)
                }
                .padding(.top, 47.0)
                .alert(alertMessage, isPresented: $showingAlert) {
                    Button("OK", role: .cancel) { }
                }
                Spacer()
            }
            .padding(.horizontal, 24.0)
            .background(Color.backgroundColor1)
            .cornerRadius(18.0)
            .padding(.top, 41.0)
            .navigationTitle("login.title")
            .background(Color.backgroundColor)
        }
        .accessibilityIdentifier(viewName)
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView(shouldShowOnboarding: .constant(true))
    }
}
