import SwiftUI

struct ThemeSwitcherView: View {
    @EnvironmentObject private var theme: AppTheme
    private let title = "appearance.mode".localized
    private let light = AppTheme.Appearance.light
    private let dark = AppTheme.Appearance.dark
    private let system = AppTheme.Appearance.system

    var body: some View {
        VStack {
            HStack {
                Text(title)
                    .fontWeight(.medium)
                Spacer()
            }
            Picker(title, selection: $theme.selectedAppearance) {
                Text(system.description).tag(system)
                Text(dark.description).tag(dark)
                Text(light.description).tag(light)
            }
            .pickerStyle(.segmented)
        }
    }
}

struct ThemeSwitcher_Previews: PreviewProvider {
    static var previews: some View {
        ThemeSwitcherView()
            .previewLayout(.sizeThatFits)
            .environmentObject(AppTheme())
    }
}
