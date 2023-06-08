//
//  CategoryEnum.swift
//  CourseJ
//
//  Created by Julia Vanchytska on 24.05.2023.
//

import Foundation
import SwiftUI

enum CategoryEnum: Int, CaseIterable {
    case design
    case painting
    case coding
    case language
    case unknown
}

extension CategoryEnum {
    static func color(for category: CategoryEnum?) -> Color {
        switch category {
        case .design: return .red
        case .painting: return .teal
        case .coding: return .orange
        case .language: return .purple
        default: return .accentColor
        }
    }

    var description: String {
        switch self {
        case .design: return "course.category.design".localized
        case .painting: return "course.category.painting".localized
        case .coding: return "course.category.coding".localized
        case .language: return "course.category.language".localized
        case .unknown: return "course.category.unknown".localized
        }
    }
}
