import Foundation
import CoreData
import SwiftUI

final class DataController: ObservableObject {
    @Published var selectedCourse: Course?
    @Published var courses: [Course] = []

    
    private init() { }
    
    static var shared = DataController()
    
    private var context = PersistenceController.context
    private var categoryArray: [Category] = []
    private var coursesArray: [Course] = []
    private var coursesModulesArray: [CourseModule] = []
    
    
    func loadDataBase() {
        let context = PersistenceController.context
        let fetchRequest: NSFetchRequest<Course> = Course.fetchRequest()
        fetchRequest.relationshipKeyPathsForPrefetching = ["CourseModule"]

        do {
            let objects = try context.fetch(fetchRequest)
            
            if objects.isEmpty {
                print("Loading data")
                self.loadCategories()
                print("Data are loaded")
            } else {
                courses = objects
                /*print("There are \(objects.count) categories")
                objects.forEach { object in
                    printData(for: object)
                }
                if let firstCategory = objects.first {
                    print("First category: \(firstCategory.category.rawValue), id: \(firstCategory.debugDescription)")
                }*/
            }
        } catch {
            let nserror = error as NSError
            print("Error getting categories: \(nserror.localizedDescription), \(nserror.userInfo)")
        }
    }
    
}

extension DataController {
    func loadCategories() {
        let categoriesData: [(CategoryEnum, String)] = [
            (.coding, "codingRec"),
            (.design, "designRec"),
            (.language, "languageRec"),
            (.painting, "paintingRec")
        ]
        
        categoriesData.forEach { categoryData in
            let category = Category(context: context)
            category.categoryId = UUID()
            category.category = categoryData.0
            category.image = categoryData.1
            categoryArray.append(category)
        }
        
        loadCourses()
        
        // add courses to categories
        categoryArray[0].courses = NSSet(array: coursesArray.filter { $0.wrappedCategory.category == .coding})
        categoryArray[1].courses = NSSet(array: coursesArray.filter { $0.wrappedCategory.category == .design})
        categoryArray[2].courses = NSSet(array: coursesArray.filter { $0.wrappedCategory.category == .language})
        categoryArray[3].courses = NSSet(array: coursesArray.filter { $0.wrappedCategory.category == .painting})
        
        do {
            try context.save()
            print("saved context")
        } catch {
            let nserror = error as NSError
            debugPrint("Unresolved error \(nserror), \(nserror.userInfo)")
        }
    }
    
    func loadCourses() {
        let coursesData: [(String, Date, Int32, Bool, Int32, String, String, Category?)] = [
            ("Mahatma Shibunamurthi", Date(), 1, false, 4, "Swift Fundamentals", "courseImage1", categoryArray.first(where: { $0.category == .coding }) ),
            ("Markus Tannenbaum", Date("2023-02-13"), 2, false, 5, "Product Design v1.0", "courseImage2", categoryArray.first(where: { $0.category == .design }) ),
            ("Jodi Hilph", Date("2023-02-15"), 1, false, 3, "Design Fundamentals", "courseImage3", categoryArray.first(where: { $0.category == .design }) ),
            ("Frederick Backman", Date("2023-02-17"), 3, false, 4, "Painting for Dummies", "courseImage4", categoryArray.first(where: { $0.category == .painting }) ),
            ("Julia Robertos", Date("2023-03-02"), 4, false, 5, "Java Development Intro", "courseImage5", categoryArray.first(where: { $0.category == .coding }) ),
            ("Heigrin Kolp", Date("2023-03-05"), 2, false, 3, "English v1.0", "courseImage6", categoryArray.first(where: { $0.category == .language }) ),
            ("Greg Bills", Date("2023-03-15"), 1, false, 4, "French A1", "courseImage7", categoryArray.first(where: { $0.category == .language }) )
        ]
        
        coursesData.forEach { courseData in
            let course = Course(context: context)
            course.courseId = UUID()
            course.author = courseData.0
            course.createdAt = courseData.1
            course.duration = courseData.2
            course.isReset = courseData.3
            course.rating = courseData.4
            course.title = courseData.5
            course.titleImage = courseData.6
            course.category = courseData.7
            coursesArray.append(course)
        }
        
        //add modules to courses
        let courseModules = loadCourseModules()
        for (index, course) in coursesArray.enumerated() {
            guard index < courseModules.count else { break }
            course.modules = NSSet(array: courseModules[index])
        }
        
       /* do {
            try context.save()
            print("saved context for courses")
        } catch {
            let nserror = error as NSError
            debugPrint("Unresolved error while saving courses \(nserror), \(nserror.userInfo)")
        }*/
        
    }
    
    func loadCourseModules() -> [[CourseModule]] {
        
        let answersArray = loadAnswers()
        var courseModulesArr: [[CourseModule]] = []
        
        let modulesData: [[(String?, ModuleType, String?, String?, CompletionStatus, Course?, NSSet?)]] = [
            [
                (
                    "Swift introduction",
                    .article,
                    nil,
                    nil,
                    .skipped,
                    coursesArray.first(where: { $0.title == "Swift Fundamentals" }),
                    nil
                ),
                (
                    nil,
                    .singleChoice,
                    "Which one is an Assignment Operator?",
                    "The assignment operator = initializes or updates the value",
                    .skipped,
                    coursesArray.first(where: { $0.title == "Swift Fundamentals" }),
                    NSSet(array: answersArray[0])
                ),
                (
                    nil,
                    .multiChoice,
                    "Which are Arithmetic Operators?",
                        """
                        Swift supports the four standard arithmetic operators for all number types:
                        - Addition (+)
                        - Subtraction (-)
                        - Multiplication (*)
                        - Division (/)
                        """,
                    .skipped,
                    coursesArray.first(where: { $0.title == "Swift Fundamentals" }),
                    NSSet(array: answersArray[1])
                ),
                (
                    nil,
                    .writeDown,
                    "How does equal to operator look like?",
                    "The equal to operator (==) is used to compare two values or expressions to check if they are equal. It returns a Boolean value (true or false) based on the result of the comparison.",
                    .skipped,
                    coursesArray.first(where: { $0.title == "Swift Fundamentals" }),
                    NSSet(array: answersArray[2])
                )
            ]
        ]
        
        for moduleData in modulesData {
            var tModulesArray: [CourseModule] = []
            
            for(moduleTitle, moduleType, modQuestion, modExplanation, completionStatusType, modCourse, modAnswers) in moduleData {
                
                let module = CourseModule(context: context)
                module.moduleId = UUID()
                module.title = moduleTitle
                module.wrappedModule = moduleType
                module.question = modQuestion
                module.explanation = modExplanation
                module.wrappedCompletionStatus = completionStatusType
                module.course = modCourse
                module.answers = modAnswers
                
                tModulesArray.append(module)
                coursesModulesArray.append(module)
            }
            courseModulesArr.append(tModulesArray)
        }
        
        //Add chapters to article modules
        let articleChapters = loadArticleChapters()
        let articlesModules = coursesModulesArray.filter { $0.wrappedModule == .article }
        for (index, articleModule) in articlesModules.enumerated() {
            guard index < articleChapters.count else { break }
            articleModule.articleChapters = NSSet(array: articleChapters[index])
        }
        
        /*do {
            try context.save()
            print("saved context for modules")
        } catch {
            let nserror = error as NSError
            debugPrint("Unresolved error while saving modules \(nserror), \(nserror.userInfo)")
        }*/
        return courseModulesArr
    }
    
    func loadArticleChapters() -> [[ArticleChapter]] {
        var articleChaptersArray: [[ArticleChapter]] = []
        
        let articleChapters: [[(String?, String?, String?, CourseModule?)]] = [
            [("""
                Swift is a new programming language for iOS, macOS, watchOS, and tvOS app development. Nonetheless, many parts of Swift will be familiar from your experience of developing in C and Objective-C.
                
                Swift provides its own versions of all fundamental C and Objective-C types, including Int for integers, Double and Float for floating-point values, Bool for Boolean values, and String for textual data. Swift also provides powerful versions of the three primary collection types, Array, Set, and Dictionary, as described in Collection Types.
                
                Like C, Swift uses variables to store and refer to values by an identifying name. Swift also makes extensive use of variables whose values can’t be changed. These are known as constants, and are much more powerful than constants in C. Constants are used throughout Swift to make code safer and clearer in intent when you work with values that don’t need to change.
                """,
              "course1_ch1",
              "The basics",
              coursesModulesArray.first(where: {$0.wrappedTitle == "Swift introduction"})
             ),
             ("""
                An operator is a special symbol or phrase that you use to check, change, or combine values. For example, the addition operator (+) adds two numbers, as in let i = 1 + 2, and the logical AND operator (&&) combines two Boolean values, as in if enteredDoorCode && passedRetinaScan.
                
                Swift supports the operators you may already know from languages like C, and improves several capabilities to eliminate common coding errors. The assignment operator (=) doesn’t return a value, to prevent it from being mistakenly used when the equal to operator (==) is intended.
                
                Swift also provides range operators that aren’t found in C, such as a..<b and a...b, as a shortcut for expressing a range of values.
                """,
              "course1_ch2",
              "Basic Operators",
              coursesModulesArray.first(where: {$0.wrappedTitle == "Swift introduction"})
             )]
        ]
        
        for articleChapter in articleChapters {
            var tArticleArr: [ArticleChapter] = []
            for (bodyText, imageName, titleArticle, courseModule) in articleChapter {
                let chapter = ArticleChapter(context: context)
                chapter.chapterId = UUID()
                chapter.body = bodyText
                chapter.image = imageName
                chapter.title = titleArticle
                chapter.module = courseModule
                tArticleArr.append(chapter)
            }
            articleChaptersArray.append(tArticleArr)
        }
        /*do {
            try context.save()
            print("saved context for chapters")
        } catch {
            let nserror = error as NSError
            debugPrint("Unresolved error while saving chapters \(nserror), \(nserror.userInfo)")
        }*/
        
        return articleChaptersArray
    }
    
    func loadAnswers() -> [[Answer]] {
        var answersArray: [[Answer]] = []
        let answersData: [[(String?, Bool)]] = [
            [("-",false), ("++", false), ("=", true), ("==", false)],
            [("+",true), ("==",false), ("-",true), ("/", true)],
            [("==", true)]
        ]
        
        for answerData in answersData {
            var tAnswersArray: [Answer] = []
            
            for (answerText, isCorrect) in answerData {
                let answer = Answer(context: context)
                answer.answerId = UUID()
                answer.answer = answerText
                answer.isCorrect = isCorrect
                tAnswersArray.append(answer)
            }
            
            answersArray.append(tAnswersArray)
            print(answersArray)
        }
        
        /*do {
            try context.save()
            print("saved context for answers")
        } catch {
            let nserror = error as NSError
            debugPrint("Unresolved error while saving answers \(nserror), \(nserror.userInfo)")
        }*/
        
        return answersArray
    }
    
    func deleteAllCategories() {
        
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "Category")
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        
        do {
            try context.execute(deleteRequest)
            try context.save()
            print("Categories were deleted")
        } catch {
            fatalError("Failed to delete data: \(error)")
        }
    }
    
    func deleteAllCourses() {
        
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "Course")
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        
        do {
            try context.execute(deleteRequest)
            try context.save()
            print("Courses were deleted")
        } catch {
            fatalError("Failed to delete data: \(error)")
        }
    }
    
    func deleteAllEntities() {
        let entityNames = ["Category", "Course", "CourseModule", "ArticleChapter", "Answer"]
        for entityName in entityNames {
            
            let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: entityName)
            let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
            
            do {
                try context.execute(deleteRequest)
                try context.save()
                print("\(entityName)s were deleted")
            } catch {
                fatalError("Failed to delete data: \(error)")
            }
        }
    
    }
    
    func checkDataBaseEntities() {
        let context = PersistenceController.context
        
        let entityNames = ["Category", "Course", "CourseModule", "ArticleChapter", "Answer"]
        
        for entityName in entityNames {
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)

            do {
                let entityCount = try context.count(for: fetchRequest)
                
                if entityCount == 0 {
                    print("\(entityName)s are empty")
                } else {
                    print("There are \(entityCount) \(entityName)s")
                    if let entities = try context.fetch(fetchRequest) as? [NSManagedObject] {
                        entities.forEach { entity in
                            printData(for: entity)
                        }
                    }
                }
            } catch {
                let nserror = error as NSError
                print("Error getting \(entityName) entities: \(nserror.localizedDescription), \(nserror.userInfo)")
            }
        }
    }
    
    func checkCoursesEntities() {
        let context = PersistenceController.context
        
        let fetchRequest: NSFetchRequest<Course> = Course.fetchRequest()

            do {
                let entityCount = try context.count(for: fetchRequest)
                
                if entityCount == 0 {
                    print("Courses are empty")
                } else {
                    print("There are \(entityCount) Courses")
                    let entities = try context.fetch(fetchRequest)
                    entities.forEach { entity in
                        printData(for: entity)
                        print("modules Array: \(entity.modulesArray.description)")
                        print("image category: \(String(describing: entity.category?.wrappedImage))")
                    }
                }
            } catch {
                let nserror = error as NSError
                print("Error getting Courses entities: \(nserror.localizedDescription), \(nserror.userInfo)")
            }
    }
    
    func printData(for object: NSManagedObject) {
        let attributes = object.entity.attributesByName
        
        for attribute in attributes {
            let attributeName = attribute.key
            let attributeValue = object.value(forKey: attributeName)
            
            print("\(attributeName): \(String(describing: attributeValue))")
        }
        
        let relationships = object.entity.relationshipsByName
        
        for relationship in relationships {
            let relationshipName = relationship.key
            let relationshipValue = object.value(forKey: relationshipName)
            
            print("\(relationshipName): \(String(describing: relationshipValue))")
        }
    }


}

