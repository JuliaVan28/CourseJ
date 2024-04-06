//
//  Course+CoreDataClass.swift
//  CourseJ
//
//  Created by Julia Vanchytska on 24.05.2023.
//
//

import Foundation
import CoreData


public class Course: NSManagedObject {
    
    public var wrappedTitle: String {
        title ?? "unknown Title"
    }
    
    public var wrappedAuthor: String {
        author ?? "unknown Author"
    }
    
    public var wrappedTitleImage: String {
        titleImage ?? "unknown Title Image"
    }
    
    public var wrappedCreatedAt: Date {
        createdAt ?? Date()
    }
    
    public var wrappedCategory: Category {
        category ?? Category()
    }
    
    public var modulesArray: [CourseModule] {
        let set = modules as? Set<CourseModule> ?? []
        return set.sorted {
            $0.wrappedTitle < $1.wrappedTitle
        }
        
    }
    
    public var currentModule = 0
    
}
