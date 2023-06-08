//
//  User+CoreDataClass.swift
//  CourseJ
//
//  Created by Julia Vanchytska on 24.05.2023.
//
//

import Foundation
import CoreData


public class User: NSManagedObject {
    
    public var wrappedEmail: String {
        email ?? "unknown Email"
    }
    
    public var wrappedName: String {
        name ?? "unknown Name"
    }
    
    public var wrappedPassword: String {
        password ?? "unknown Password"
    }
    
    public var usersCoursesArray: [Course] {
        let set = usersCourses as? Set<Course> ?? []
            return set.sorted {
                $0.wrappedTitle < $1.wrappedTitle
            }
    }
}
