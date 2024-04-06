//
//  CourseModule+CoreDataClass.swift
//  CourseJ
//
//  Created by Julia Vanchytska on 24.05.2023.
//
//

import Foundation
import CoreData


public class CourseModule: NSManagedObject {
    
    public var wrappedTitle: String {
        title ?? "unknown Title"
    }
    
    public var wrappedQuestion: String {
        question ?? "unknown question"
    }
    
    var wrappedModule: ModuleType {
        get { return ModuleType.init(rawValue: Int(type)) ?? .unknown }
        set { type = Int16(newValue.rawValue) }
    }
    
    var wrappedCompletionStatus: CompletionStatus {
        get { return CompletionStatus.init(rawValue: Int(completionStatus)) ?? .unknown }
        set { type = Int16(newValue.rawValue) }
    }
    
    var wrappedAnswers: [Answer] {
        let set = answers as? Set<Answer> ?? []
        return set.sorted {
            $0.wrappedAnswer < $1.wrappedAnswer
        }
    }
    
    var wrappedArticleChapters: [ArticleChapter] {
        let set = articleChapters as? Set<ArticleChapter> ?? []
        return set.sorted {
            $0.wrappedTitle < $1.wrappedTitle
        }
    }
    
    var selectedAnswers: [Answer] = []
}
