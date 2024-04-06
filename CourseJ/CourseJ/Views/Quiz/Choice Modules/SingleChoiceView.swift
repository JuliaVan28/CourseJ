import SwiftUI

struct SingleChoiceView: View {
    var moduleItem: CourseModule
    let continueAction: () -> Void

    @EnvironmentObject private var module: ChoiceModulesController
    @EnvironmentObject private var quiz: QuizController
    @State private var isCorrect = false

    var body: some View {
        VStack(spacing: 7) {
            ChoiceView(
                moduleItem,
                moduleExplanation: "quiz.singlechoice.task",
                submitAction: submitAction,
                continueAction: continueAction,
                setExplanationAnswer: { module.setSingleExplanationAnswer(for: moduleItem) }
            ) {
                RadioButtonGroup(
                    options: moduleItem.wrappedAnswers.map {$0.wrappedAnswer},
                    selectedOption: $module.config.selectedOption,
                    buttonColor: $module.config.buttonColor,
                    isDisabled: $module.config.isDisabled
                )
            }
        }
        .onAppear { module.loadExistingSingleAnswer(for: moduleItem) }
        .accessibilityIdentifier(viewName)
    }
}

private extension SingleChoiceView {
    func submitAction() {
        if !module.config.isSubmitDisabled {
            module.checkAnswers([module.config.selectedOption], for: moduleItem)
            let currentModule = quiz.course.modulesArray.firstIndex(of: moduleItem)!
            quiz.completeModule(at: currentModule, withStatus: module.config.areAnswersCorrect)
            if let answerToSave = moduleItem.wrappedAnswers.first(where: {$0.wrappedAnswer == module.config.selectedOption}) {
                quiz.saveSelectedAnswers(answers: [answerToSave], for: moduleItem)
            }
        }
    }
}

struct SingleChoiceView_Previews: PreviewProvider {
    static var module = CourseModule()

    static var previews: some View {
        SingleChoiceView(moduleItem: module) {}
            .environmentObject(ChoiceModulesController())
    }
}
