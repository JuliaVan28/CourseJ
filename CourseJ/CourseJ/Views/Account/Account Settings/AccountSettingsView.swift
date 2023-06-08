import SwiftUI
import Auth0

struct AccountSettingsView: View {
    @Binding var shouldShowOnboarding: Bool
    
    @State private var username: String = "Julia"
    @State private var email: String = "julia.van@i.ua"
    
    
    var body: some View {
        ScrollView {
                VStack(alignment: .leading) {
                    TextFieldWithTitle(title: "login.name".localized, text: $username)
                    TextFieldWithTitle(title: "login.email".localized, text: $email).disabled(true)
                    Button {
                        //Save action
                    } label: {
                        RoundedButton(title: "account.settings.save".localized, width: .infinity)
                    }.padding(.top, 30.0)
                        .padding(.bottom, 30.0)
                    
                }.padding(.horizontal, 24.0)
                    .background(Color.backgroundColor1)
                    .cornerRadius(18.0)
                    .padding(.top, 15.0)
        }
        .safeAreaInset(edge: .bottom) {
            Button {
                Auth0
                    .webAuth()
                    .clearSession { result in
                        switch result {
                        case .success:
                            print("Logged out")
                            shouldShowOnboarding = true
                        case .failure(let error):
                            print("Failed with: \(error)")
                        }
                    }
                
            } label: {
                RoundedButton(title: "account.logout".localized, width: .infinity)
            }.font(.poppinsBodyFixed)
                .padding(.horizontal, .Padding)
                .padding(.bottom, 30.0)
        }
        .backgroundColorStyle()
        .navigationTitle("account.edit".localized)
    }
}

struct AccountSettingsView_Previews: PreviewProvider {
    static var previews: some View {
        AccountSettingsView(shouldShowOnboarding: .constant(true))
    }
}
