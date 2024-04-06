import SwiftUI

struct ChoiceView<Content>: View where Content: View {
    let moduleItem: CourseModule
    let moduleExplanation: String?
    let submitAction: () -> Void
    let continueAction: () -> Void
    let setExplanationAnswer: () -> Void
    let content: Content

    @EnvironmentObject private var module: ChoiceModulesController
    @EnvironmentObject private var quiz: QuizController
    private var isSubmitDisabled: Bool {
        module.config.currentButton == .continueButton ? false : module.config.isSubmitDisabled
    }

    init(
        _ moduleItem: CourseModule,
        moduleExplanation: String,
        submitAction: @escaping () -> Void,
        continueAction: @escaping () -> Void,
        setExplanationAnswer: @escaping () -> Void,
        @ViewBuilder content: () -> Content
    ) {
        self.moduleItem = moduleItem
        self.moduleExplanation = moduleExplanation
        self.submitAction = submitAction
        self.continueAction = continueAction
        self.setExplanationAnswer = setExplanationAnswer
        self.content = content()
    }

    var body: some View {
        ScrollView {
            Group {
                if let explanation = moduleExplanation {
                    Text(explanation.localized)
                        .font(.poppinsBodyFixed)
                        .fontWeight(.semibold)
                        .foregroundColor(Color.secondaryColor)
                }
                if let question = moduleItem.question {
                    Text(question)
                        .font(.poppinsTitle)
                        .fontWeight(.semibold)
                        .padding(.top, 7)
                }

                HStack {
                    Spacer()
                    content
                    Spacer()
                }

                Text(module.config.explanation ?? "")
                    .padding(.top)
            }
            .padding(.horizontal, .Padding)
        }
        .safeAreaInset(edge: .bottom) {
            QuizBottomButtonsBar {
                Button("quiz.explanation".localized) {
                    module.explanationButtonAction(moduleItem: moduleItem)
                    setExplanationAnswer()
                    submitAction()
                }
                .font(.poppinsBodyFixed)

                Button {
                    switch module.config.currentButton {
                    case .submitButton: submitAction()
                    case .continueButton: continueAction()
                    }
                } label: {
                    RoundedButton(title: module.config.currentButton.rawValue)
                        .disabled(isSubmitDisabled)
                }
            }
        }
        .accessibilityIdentifier(viewName)
    }
}

struct ChoiceView_Previews: PreviewProvider {
    static var module = CourseModule()

    static var previews: some View {
        ChoiceView(
            module,
            moduleExplanation: "Select an answer",
            submitAction: {},
            continueAction: {},
            setExplanationAnswer: {}
        ) {
            Text("Heey")
        }
        .environmentObject(ChoiceModulesController())
    }
}
