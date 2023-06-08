import SwiftUI
struct WriteDownView: View {
    var moduleItem: CourseModule
    let continueAction: () -> Void

    @EnvironmentObject private var quiz: QuizController
    @EnvironmentObject private var module: ChoiceModulesController
    @State private var isCorrect = false

    var body: some View {
        ChoiceView(
            moduleItem,
            moduleExplanation: "quiz.writedown.task",
            submitAction: submitAction,
            continueAction: continueAction,
            setExplanationAnswer: { module.setSingleExplanationAnswer(for: moduleItem) }
        ) {
            TextFieldWithClearButton(
                text: $module.config.selectedOption,
                backgroundColor: module.config.buttonColor,
                callback: setSubmitButtonState
            )
            .disabled(module.config.isDisabled)
        }
        .onAppear { module.loadExistingSingleAnswer(for: moduleItem) }
        .accessibilityIdentifier(viewName)
    }
}

private extension WriteDownView {
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

    func setSubmitButtonState(_ isDisabled: Bool) { module.config.isSubmitDisabled = isDisabled }
}

struct WriteDownView_Previews: PreviewProvider {
    static var module = CourseModule()

    static var previews: some View {
        WriteDownView(moduleItem: module) {}
            .environmentObject(ChoiceModulesController())
    }
}
