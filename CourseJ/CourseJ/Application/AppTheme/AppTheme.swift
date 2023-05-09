//
//  AppTheme.swift
//  CourseJ
//
//  Created by Julia Vanchytska on 08.05.2023.
//

import SwiftUI

@MainActor
final class AppTheme: ObservableObject {
    @Published var colorScheme: ColorScheme? = .dark

    var selectedAppearance: Appearance {
        get {
            switch colorScheme {
            case .some(.dark): return Appearance.dark
            case .some(.light): return Appearance.light
            case .none, .some: return Appearance.system
            }
        }
        set {
            switch newValue {
            case .dark: colorScheme = .dark
            case .light: colorScheme = .light
            case .system: colorScheme = nil
            }
        }
    }

    enum Appearance {
        case system, light, dark

        var description: String {
            switch self {
            case .system: return "appearance.system".localized
            case .light: return "appearance.light".localized
            case .dark: return "appearance.dark".localized
            }
        }
    }
}
