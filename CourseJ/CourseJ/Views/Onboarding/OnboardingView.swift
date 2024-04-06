import SwiftUI
import Auth0

struct OnboardingView: View {
    @Binding var shouldShowOnboarding: Bool
   
    @StateObject private var loginController: LoginController
    @State private var pageIndex = 0
    @State private var showingAlert = false
    private let onboardingItems = OnboardingItem.items
    
    init(shouldShowOnboarding: Binding<Bool>) {
        _shouldShowOnboarding = shouldShowOnboarding
        _loginController = StateObject(wrappedValue: LoginController())
    }

    var body: some View {
            VStack {
                TabView(selection: $pageIndex) {
                    ForEach(onboardingItems.indices, id: \.self) { index in
                        OnboardingItemView(
                            title: onboardingItems[index].title,
                            imageName: onboardingItems[index].imageName
                        )
                    }
                }
                .tabViewStyle(.page(indexDisplayMode: .never))
                Spacer(minLength: 30.0)
                PageIndicator(pageIndex: $pageIndex, pagesCount: onboardingItems.count)
                Spacer(minLength: 80.0)
                Button {
                    Auth0
                        .webAuth()
                        .start { result in
                            switch result {
                            case .success(let credentials):
                                print("Obtained credentials: \(credentials)")
                                shouldShowOnboarding.toggle()
                            case .failure(let error):
                                showingAlert = true
                                print("Failed with: \(error)")
                            }
                        }
                } label: {
                    RoundedButton(title: "onboarding.login", width: 160)
                }
                Spacer(minLength: 40.0)
            }
            .alert("Failed to authenticate", isPresented: $showingAlert) {
                Button("OK", role: .cancel) { }
            }
            .font(.poppinsBody)
            .background(Color.backgroundColor)
            .accessibilityIdentifier(viewName)
        }
}


struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView(shouldShowOnboarding: .constant(true))
    }
}
