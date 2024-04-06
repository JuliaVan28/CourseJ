import SwiftUI

final class TemporaryCoursesPersistentStore: ObservableObject {
    @Environment(\.managedObjectContext) private var moc
    @FetchRequest(sortDescriptors: []) var users: FetchedResults<User>
    @EnvironmentObject private var dataController: DataController

    @Published var courses: [Course] = []
    @Published var selectedCourse: Course?

    private init() {
        if let userCourses = users.map({$0.usersCoursesArray}).first {
            _courses = Published(initialValue: userCourses)
            _selectedCourse = Published(initialValue: courses.first!)
        }        
    }

    static var shared = TemporaryCoursesPersistentStore()

    func updateCourseInCourseStore(for course: Course) {
        if let courseIndex = Self.shared.courses.firstIndex(where: { $0.courseId == course.courseId }) {
            Self.shared.courses[courseIndex] = course
        }
    }

    func storeSelectedAnswersToCourseStore(_ course: Course, for moduleIndex: Int, with answers: [Answer]) {
        if let courseIndex = Self.shared.courses.firstIndex(where: { $0.courseId == course.courseId }) {
            Self.shared.courses[courseIndex].modulesArray[moduleIndex].selectedAnswers.removeAll()
            Self.shared.courses[courseIndex].modulesArray[moduleIndex].selectedAnswers.append(contentsOf: answers)
        }
    }

    func getModule(for moduleItem: CourseModule) -> CourseModule? {
        selectedCourse?.modulesArray.first { $0 == moduleItem }
    }
}

final class QuizController: ObservableObject {
    @Published var areStatsPresented = false
    @Published var course: Course
    @Published var isPresented = false

    init(course: Course) {
        self.course = course
    }

    func saveSelectedAnswers(answers: [Answer], for moduleItem: CourseModule) {
        guard let moduleIndex = course.modulesArray.firstIndex(where: { $0.id == moduleItem.id }) else { return }
        course.modulesArray[moduleIndex].selectedAnswers.removeAll()
        course.modulesArray[moduleIndex].selectedAnswers.append(contentsOf: answers)
        TemporaryCoursesPersistentStore.shared.storeSelectedAnswersToCourseStore(course, for: moduleIndex, with: answers)
        TemporaryCoursesPersistentStore.shared.updateCourseInCourseStore(for: course)
    }

    func calculateModuleProgression() {
        if course.progressValue < course.progressTotal {
            goToModule(at: course.currentModule + 1)
        } else {
            areStatsPresented = true
        }
        TemporaryCoursesPersistentStore.shared.updateCourseInCourseStore(for: course)
    }

    func completeModule(at index: Int, withStatus completionStatus: Bool) {
        course.modulesArray[index].wrappedCompletionStatus = completionStatus == true ? .correct : .incorrect
        TemporaryCoursesPersistentStore.shared.updateCourseInCourseStore(for: course)
    }

    func goToModule(at index: Int) { course.currentModule = index }

    func restartCourse() {
        course.modulesArray.indices.forEach {
            course.modulesArray[$0].wrappedCompletionStatus = .skipped
            course.modulesArray[$0].selectedAnswers.removeAll()
        }
        goToModule(at: 0)
        course.isReset = true
        TemporaryCoursesPersistentStore.shared.updateCourseInCourseStore(for: course)
    }

    func resumeCourse() {
        course.currentModule = course.modulesArray.firstIndex { $0.wrappedCompletionStatus == .skipped } ?? 0
    }

    func completeCourse() {
        goToModule(at: 0)
        TemporaryCoursesPersistentStore.shared.updateCourseInCourseStore(for: course)
    }
}
