//
//  CourseModule+CoreDataProperties.swift
//  CourseJ
//
//  Created by Julia Vanchytska on 24.05.2023.
//
//

import Foundation
import CoreData


extension CourseModule {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CourseModule> {
        return NSFetchRequest<CourseModule>(entityName: "CourseModule")
    }

    @NSManaged public var moduleId: UUID?
    @NSManaged public var title: String?
    @NSManaged public var type: Int16
    @NSManaged public var question: String?
    @NSManaged public var explanation: String?
    @NSManaged public var completionStatus: Int16
    @NSManaged public var course: Course?
    @NSManaged public var articleChapters: NSSet?
    @NSManaged public var answers: NSSet?

}

// MARK: Generated accessors for articleChapters
extension CourseModule {

    @objc(addArticleChaptersObject:)
    @NSManaged public func addToArticleChapters(_ value: ArticleChapter)

    @objc(removeArticleChaptersObject:)
    @NSManaged public func removeFromArticleChapters(_ value: ArticleChapter)

    @objc(addArticleChapters:)
    @NSManaged public func addToArticleChapters(_ values: NSSet)

    @objc(removeArticleChapters:)
    @NSManaged public func removeFromArticleChapters(_ values: NSSet)

}

// MARK: Generated accessors for answers
extension CourseModule {

    @objc(addAnswersObject:)
    @NSManaged public func addToAnswers(_ value: Answer)

    @objc(removeAnswersObject:)
    @NSManaged public func removeFromAnswers(_ value: Answer)

    @objc(addAnswers:)
    @NSManaged public func addToAnswers(_ values: NSSet)

    @objc(removeAnswers:)
    @NSManaged public func removeFromAnswers(_ values: NSSet)

}

extension CourseModule : Identifiable {

}
