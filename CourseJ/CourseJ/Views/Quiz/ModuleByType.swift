import SwiftUI

struct ModuleByType: View {
    var moduleItem: CourseModule
    var continueAction: () -> Void

    @StateObject private var module = ChoiceModulesController()
    @EnvironmentObject private var quiz: QuizController

    var body: some View {
        Group {
            switch moduleItem.wrappedModule {
            case .article:
                QuizArticle(moduleItem: moduleItem, continueAction: continueAction)
            case .singleChoice:
                SingleChoiceView(moduleItem: moduleItem, continueAction: continueAction)
            case .multiChoice:
                MultipleChoiceView(moduleItem: moduleItem, continueAction: continueAction)
            case .writeDown:
                WriteDownView(moduleItem: moduleItem, continueAction: continueAction)
            case .unknown:
                QuizArticle(moduleItem: moduleItem, continueAction: continueAction)
            }
        }
        .environmentObject(module)
        .onChange(of: quiz.course.isReset) { _ in
            module.resetModule()
            quiz.course.isReset = false
        }
        .accessibilityIdentifier(viewName)
    }
}

struct ModuleByType_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ModuleByType(moduleItem: CourseModule()) {}
                .previewDisplayName("Article")
            ModuleByType(moduleItem: CourseModule()) {}
                .previewDisplayName("Questions")
        }
        .environmentObject(QuizController(course: MockData.courseOne))
    }
}
