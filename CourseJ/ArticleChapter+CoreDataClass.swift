//
//  ArticleChapter+CoreDataClass.swift
//  CourseJ
//
//  Created by Julia Vanchytska on 24.05.2023.
//
//

import Foundation
import CoreData


public class ArticleChapter: NSManagedObject {
    
    public var wrappedTitle: String {
        title ?? "unknown Title"
    }
    
    public var wrappedBody: String {
        body ?? "unknown Body"
    }
    
    public var wrappedImage: String {
        image ?? "unknownImage"
    }
    
    public var wrappedModule: CourseModule {
        module ?? CourseModule()
    }
}
