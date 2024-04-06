import SwiftUI

@main
struct CourseJApp: App {
    @AppStorage("shouldShowOnboarding") private var shouldShowOnboarding = true
    @StateObject private var theme = AppTheme()

    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            TabBarView(persistenceController: persistenceController)
                .fullScreenCover(isPresented: $shouldShowOnboarding) {
                    OnboardingView(shouldShowOnboarding: $shouldShowOnboarding)
                        .preferredColorScheme(.dark)
                }
                .environmentObject(theme)
                .environmentObject(DataController.shared)
                .environment(\.managedObjectContext, PersistenceController.context)
        }
    }
}
