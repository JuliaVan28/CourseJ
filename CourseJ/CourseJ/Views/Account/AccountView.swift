import SwiftUI

struct AccountView: View {
    @State private var shouldShowOnboarding: Bool = false

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 22) {
                    Image("avatar")
                        .resizable()
                        .frame(width: 64, height: 64)
                        .padding(.top)
                    ForEach(Self.AccountItemScreen.allCases) { screen in
                        AccountRoute(screen.displayName) {
                            destinationView(for: screen)
                        }
                    }
                }
            }
            .backgroundColorStyle()
            .navigationTitle(TabBarItemScreen.account.displayName)
        }
        .accessibilityIdentifier(viewName)
    }
}

// MARK: - AccountView DataSource

private extension AccountView {
    enum AccountItemScreen: String, CaseIterable, Identifiable {
        var id: String { rawValue }

        case edit
        case settings
        case help

        var displayName: String {
            switch self {
            case .edit: return "account.edit".localized
            case .settings: return "account.settings.privacy".localized
            case .help: return "account.help".localized
            }
        }
    }

    @ViewBuilder
    func destinationView(for screen: AccountView.AccountItemScreen) -> some View {
        switch screen {
        case .edit: AccountSettingsView(shouldShowOnboarding: $shouldShowOnboarding)
                .fullScreenCover(isPresented: $shouldShowOnboarding) {
            OnboardingView(shouldShowOnboarding: $shouldShowOnboarding)
                .preferredColorScheme(.dark)
        }
        case .settings: SettingsAndPrivacyView()
        case .help: HelpView()
        }
    }
}

struct AccountView_Previews: PreviewProvider {
    static var previews: some View {
        AccountView()
    }
}
