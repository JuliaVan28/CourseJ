//
//  OnboardingItem.swift
//  CourseJ
//
//  Created by Julia Vanchytska on 08.05.2023.
//

import Foundation

struct OnboardingItem: Hashable {
    let title: String
    let imageName: String

    static let items = [
        Self(title: "onboarding.1".localized, imageName: "illustration1"),
        Self(title: "onboarding.2".localized, imageName: "illustration2"),
        Self(title: "onboarding.3".localized, imageName: "illustration3"),
    ]
}
