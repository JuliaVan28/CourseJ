//
//  Category+CoreDataClass.swift
//  CourseJ
//
//  Created by Julia Vanchytska on 24.05.2023.
//
//

import Foundation
import CoreData


public class Category: NSManagedObject {

    var category: CategoryEnum {
        get { return CategoryEnum.init(rawValue: Int(categoryType)) ?? .unknown }
        set { categoryType = Int16(newValue.rawValue) }
    }
    
    public var wrappedImage: String {
        image ?? "unknownImage"
    }
    
    public var coursesArray: [Course] {
        let set = courses as? Set<Course> ?? []
            return set.sorted {
                $0.wrappedTitle < $1.wrappedTitle
            }
            
    }
    
}
