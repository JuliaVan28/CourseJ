//
//  Course+CoreDataProperties.swift
//  CourseJ
//
//  Created by Julia Vanchytska on 24.05.2023.
//
//

import Foundation
import CoreData


extension Course {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Course> {
        return NSFetchRequest<Course>(entityName: "Course")
    }

    @NSManaged public var author: String?
    @NSManaged public var courseId: UUID?
    @NSManaged public var createdAt: Date?
    @NSManaged public var duration: Int32
    @NSManaged public var isReset: Bool
    @NSManaged public var rating: Int32
    @NSManaged public var title: String?
    @NSManaged public var titleImage: String?
    @NSManaged public var category: Category?
    @NSManaged public var modules: NSSet?

}

// MARK: Generated accessors for modules
extension Course {

    @objc(addModulesObject:)
    @NSManaged public func addToModules(_ value: CourseModule)

    @objc(removeModulesObject:)
    @NSManaged public func removeFromModules(_ value: CourseModule)

    @objc(addModules:)
    @NSManaged public func addToModules(_ values: NSSet)

    @objc(removeModules:)
    @NSManaged public func removeFromModules(_ values: NSSet)

}

extension Course {
    var doneModules: Int { modulesArray.filter { $0.wrappedCompletionStatus != .skipped }.count }
    var totalModules: Int { modulesArray.count }
    var correctModules: Int { modulesArray.filter { $0.wrappedCompletionStatus == .correct }.count }
    var progressValue: CGFloat { CGFloat(currentModule) }
    var progressTotal: CGFloat { CGFloat(modulesArray.count - 1) }
    var isCourseCompleted: Bool { !modulesArray.contains { $0.wrappedCompletionStatus == .skipped } }



}
