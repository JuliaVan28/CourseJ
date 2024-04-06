import SwiftUI

struct SettingsAndPrivacyView: View {
    var body: some View {
        ScrollView {
            ThemeSwitcherView()
                .padding()
        }
        .backgroundColorStyle()
        .navigationTitle("account.settings.privacy".localized)
    }
}

struct SettingsAndPrivacyView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsAndPrivacyView().environmentObject(AppTheme())
    }
}
