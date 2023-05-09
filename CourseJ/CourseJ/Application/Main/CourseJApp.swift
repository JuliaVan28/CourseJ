//
//  CourseJApp.swift
//  CourseJ
//
//  Created by Julia Vanchytska on 05.05.2023.
//

import SwiftUI

@main
struct CourseJApp: App {
    @AppStorage("shouldShowOnboarding") private var shouldShowOnboarding = true
    @StateObject private var theme = AppTheme()

    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            TabBarView()
                .fullScreenCover(isPresented: $shouldShowOnboarding) {
                    OnboardingView(shouldShowOnboarding: $shouldShowOnboarding)
                        .preferredColorScheme(.light)
                }
                .environmentObject(theme)
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
