//
//  Answer+CoreDataProperties.swift
//  CourseJ
//
//  Created by Julia Vanchytska on 24.05.2023.
//
//

import Foundation
import CoreData


extension Answer {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Answer> {
        return NSFetchRequest<Answer>(entityName: "Answer")
    }

    @NSManaged public var answer: String?
    @NSManaged public var answerId: UUID?
    @NSManaged public var isCorrect: Bool

}

extension Answer : Identifiable {

}
