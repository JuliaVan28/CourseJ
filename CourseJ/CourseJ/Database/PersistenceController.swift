//
//  Persistence.swift
//  CourseJ
//
//  Created by Julia Vanchytska on 05.05.2023.
//

import CoreData

public class PersistenceController {
    static let shared = PersistenceController()
    
    private init() {}

    public static var context: NSManagedObjectContext {
        persistentContainer.viewContext
    }
    
    public static var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "CourseJ")
        container.loadPersistentStores { _, error in
            if let error = error as NSError? {
                debugPrint("Unresolved error \(error), \(error.userInfo)")
            }
        }
        return container
    }()
    
    public static func saveContext() {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                debugPrint("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }

   
}
