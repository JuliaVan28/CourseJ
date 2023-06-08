//
//  Answer+CoreDataClass.swift
//  CourseJ
//
//  Created by Julia Vanchytska on 24.05.2023.
//
//

import Foundation
import CoreData


public class Answer: NSManagedObject {
    public var wrappedAnswer: String {
        answer ?? "unknown Answer"
    }
}
