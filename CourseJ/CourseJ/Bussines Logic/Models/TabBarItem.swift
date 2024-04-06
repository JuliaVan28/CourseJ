//
//  TabBarItem.swift
//  CourseJ
//
//  Created by Julia Vanchytska on 08.05.2023.
//

import SwiftUI

enum TabBarItem: String, CaseIterable, Identifiable {
    var id: String { rawValue }

    case home
    case courses
    case myCourses
    case account

    var displayName: String {
        switch self {
        case .home: return "tab.item.title.home".localized
        case .courses: return "tab.item.title.courses".localized
        case .myCourses: return "tab.item.title.myCourses".localized
        case .account: return "tab.item.title.account".localized
        }
    }

    var image: String {
        switch self {
        case .home: return "home"
        case .courses: return "courses"
        case .myCourses: return "myCourses"
        case .account: return "account"
        }
    }

    var label: Label<Text, Image> {
        Label(displayName, image: image)
    }
}

