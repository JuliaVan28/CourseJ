//
//  Category+CoreDataProperties.swift
//  CourseJ
//
//  Created by Julia Vanchytska on 24.05.2023.
//
//

import Foundation
import CoreData


extension Category {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Category> {
        return NSFetchRequest<Category>(entityName: "Category")
    }

    @NSManaged public var categoryId: UUID?
    @NSManaged public var categoryType: Int16
    @NSManaged public var image: String?
    @NSManaged public var courses: NSSet?

}

// MARK: Generated accessors for courses
extension Category {

    @objc(addCoursesObject:)
    @NSManaged public func addToCourses(_ value: Course)

    @objc(removeCoursesObject:)
    @NSManaged public func removeFromCourses(_ value: Course)

    @objc(addCourses:)
    @NSManaged public func addToCourses(_ values: NSSet)

    @objc(removeCourses:)
    @NSManaged public func removeFromCourses(_ values: NSSet)

}

extension Category : Identifiable {

}
