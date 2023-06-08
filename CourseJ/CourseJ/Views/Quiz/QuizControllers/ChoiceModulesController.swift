import SwiftUI

final class ChoiceModulesController: ObservableObject {
    @Published var config = ModuleSettings()

    struct ModuleSettings {
        var buttonColor: Color = .ChoiceQuiz.selectedRadioButtonColor
        var explanation: AttributedString?
        var currentButton: ActionButton = .submitButton
        var isDisabled = false
        var isSubmitDisabled = true
        var isExplanationActive = false
        var completionStatus: CompletionStatus = .skipped
        var areAnswersCorrect = false
        var selectedMultiOptions: [String] = []
        var selectedOption: String = ""
    }

    enum ButtonStates { case selected, correct, incorrect }
    enum ActionButton: String {
        case submitButton = "quiz.button.submit"
        case continueButton = "quiz.button.continue"
    }

    func resetModule() { config = ModuleSettings() }

    func checkAnswers(_ selectedAnswers: [String], for moduleItem: CourseModule) {
        guard selectedAnswers.isNotEmpty else { return }

        let sortedSelectedAnswers = selectedAnswers.sorted().map { $0.lowercased() }
        let sortedCorrectAnswers = moduleItem.wrappedAnswers.filter {$0.isCorrect == true }.sorted { $0.wrappedAnswer < $1.wrappedAnswer }.map { $0.wrappedAnswer.lowercased() }

        if config.isExplanationActive {
            config.areAnswersCorrect = false
        } else {
            config.areAnswersCorrect = sortedCorrectAnswers == sortedSelectedAnswers
            changeColor(config.areAnswersCorrect ? .correct : .incorrect)
        }
        updateToDisabledUI(isCorrect: config.areAnswersCorrect)
    }

    func changeColor(_ state: ButtonStates) {
        switch state {
        case .selected:
            config.buttonColor = .ChoiceQuiz.selectedRadioButtonColor
        case .correct:
            config.buttonColor = .ChoiceQuiz.correctColor
        case .incorrect:
            config.buttonColor = .ChoiceQuiz.incorrectColor
        }
    }

    func updateToDisabledUI(isCorrect: Bool) {
        config.currentButton = .continueButton
        config.isDisabled = true
        config.completionStatus = isCorrect == true ? .correct : .incorrect
    }

    func explanationButtonAction(moduleItem: CourseModule) {
        config.isExplanationActive = true
        config.explanation = try? AttributedString(
            markdown: "**\("quiz.explanation".localized):**\n" +
                "\(moduleItem.explanation ?? "")",
            options: AttributedString.MarkdownParsingOptions(
                interpretedSyntax: .inlineOnlyPreservingWhitespace
            )
        )
        changeColor(.selected)
        config.isSubmitDisabled = false
        if !isDone { updateToDisabledUI(isCorrect: false) }
    }
}

extension ChoiceModulesController {
    var isDone: Bool { config.completionStatus != .skipped ? true : false }
}

// MARK: - Single choice actions

extension ChoiceModulesController {
    func loadExistingSingleAnswer(for moduleItem: CourseModule) {
        let currentModule = TemporaryCoursesPersistentStore.shared.getModule(for: moduleItem)
        if let option = currentModule?.selectedAnswers.first?.wrappedAnswer {
            config.selectedOption = option
            checkAnswers([config.selectedOption], for: moduleItem)
        }
    }

    func setSingleExplanationAnswer(for moduleItem: CourseModule) {
        config.selectedOption = moduleItem.wrappedAnswers.first(where: {$0.isCorrect == true })!.wrappedAnswer
    }
}

// MARK: - Multi choice actions

extension ChoiceModulesController {
    func loadExistingMultiAnswers(for moduleItem: CourseModule) {
        let currentModule = TemporaryCoursesPersistentStore.shared.selectedCourse?.modulesArray.first { $0 == moduleItem }
        if let options = currentModule?.selectedAnswers.map({$0.wrappedAnswer}) {
            config.selectedMultiOptions = options
            checkAnswers(config.selectedMultiOptions, for: moduleItem)
        }
    }

    func setMultiExplanationAnswer(for moduleItem: CourseModule) {
        config.selectedMultiOptions = moduleItem.wrappedAnswers.filter {$0.isCorrect == true }.map({$0.wrappedAnswer})
    }
}
