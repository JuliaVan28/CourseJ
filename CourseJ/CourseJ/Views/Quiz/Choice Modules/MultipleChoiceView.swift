import SwiftUI

struct MultipleChoiceView: View {
    var moduleItem: CourseModule
    let continueAction: () -> Void

    @EnvironmentObject private var quiz: QuizController
    @EnvironmentObject private var module: ChoiceModulesController
    @State private var isCorrect = false

    var body: some View {
        VStack(spacing: 7) {
            ChoiceView(
                moduleItem,
                moduleExplanation: "quiz.multiplechoice.task",
                submitAction: submitAction,
                continueAction: continueAction,
                setExplanationAnswer: { module.setMultiExplanationAnswer(for: moduleItem) }
            ) {
                VStack(spacing: 2) {
                    ForEach(moduleItem.wrappedAnswers, id: \.self) { option in
                        MultipleChoiceButton(
                            selectedOptions: $module.config.selectedMultiOptions,
                            buttonColor: $module.config.buttonColor,
                            option: option.wrappedAnswer
                        )
                        .disabled(module.config.isDisabled)
                    }
                }
            }
        }
        .onAppear { module.loadExistingMultiAnswers(for: moduleItem) }
        .accessibilityIdentifier(viewName)
    }
}

private extension MultipleChoiceView {
    func submitAction() {
        if !module.config.isSubmitDisabled {
            module.checkAnswers(module.config.selectedMultiOptions, for: moduleItem)
            let currentModule = quiz.course.modulesArray.firstIndex(of: moduleItem)!
            quiz.completeModule(at: currentModule, withStatus: module.config.areAnswersCorrect)
            let answersToSave = moduleItem.wrappedAnswers.filter({ answer in
                module.config.selectedMultiOptions.contains(answer.wrappedAnswer)
            })
            quiz.saveSelectedAnswers(answers: answersToSave, for: moduleItem)
           // quiz.saveSelectedAnswers(answers: module.config.selectedMultiOptions, for: moduleItem)
        }
    }
}

struct MultipleChoiceView_Previews: PreviewProvider {
    static var module = CourseModule()

    static var previews: some View {
        MultipleChoiceView(moduleItem: module) {}
            .environmentObject(ChoiceModulesController())
    }
}
