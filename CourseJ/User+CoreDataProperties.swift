//
//  User+CoreDataProperties.swift
//  CourseJ
//
//  Created by Julia Vanchytska on 24.05.2023.
//
//

import Foundation
import CoreData


extension User {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<User> {
        return NSFetchRequest<User>(entityName: "User")
    }

    @NSManaged public var email: String?
    @NSManaged public var name: String?
    @NSManaged public var password: String?
    @NSManaged public var userId: UUID?
    @NSManaged public var usersCourses: NSSet?

}

// MARK: Generated accessors for usersCourses
extension User {

    @objc(addUsersCoursesObject:)
    @NSManaged public func addToUsersCourses(_ value: Course)

    @objc(removeUsersCoursesObject:)
    @NSManaged public func removeFromUsersCourses(_ value: Course)

    @objc(addUsersCourses:)
    @NSManaged public func addToUsersCourses(_ values: NSSet)

    @objc(removeUsersCourses:)
    @NSManaged public func removeFromUsersCourses(_ values: NSSet)

}

extension User : Identifiable {

}
