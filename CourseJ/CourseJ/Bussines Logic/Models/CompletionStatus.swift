//
//  CompletionStatus.swift
//  CourseJ
//
//  Created by Julia Vanchytska on 25.05.2023.
//

import Foundation

enum CompletionStatus: Int, Codable, Hashable, CaseIterable {
    case skipped
    case correct
    case incorrect
    case unknown
}

extension CompletionStatus {
    func isCorrect() -> Bool {
        if case .correct = self {
            return true
        } else {
            return false
        }
    }
}
