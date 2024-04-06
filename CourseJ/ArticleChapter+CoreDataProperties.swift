//
//  ArticleChapter+CoreDataProperties.swift
//  CourseJ
//
//  Created by Julia Vanchytska on 24.05.2023.
//
//

import Foundation
import CoreData


extension ArticleChapter {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ArticleChapter> {
        return NSFetchRequest<ArticleChapter>(entityName: "ArticleChapter")
    }

    @NSManaged public var body: String?
    @NSManaged public var chapterId: UUID?
    @NSManaged public var image: String?
    @NSManaged public var title: String?
    @NSManaged public var module: CourseModule?

}

extension ArticleChapter : Identifiable {

}
