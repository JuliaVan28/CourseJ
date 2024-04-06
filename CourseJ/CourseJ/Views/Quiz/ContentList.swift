import SwiftUI

struct ContentList: View {
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject private var quiz: QuizController
    private var modules: [CourseModule] { quiz.course.modulesArray }
    private func currentItemBackground(at index: Int) -> some View {
        let color: Color = index == quiz.course.currentModule
            ? .secondaryColor
            : .clear
        return color.opacity(0.2)
    }

    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                HStack {
                    Spacer()
                    Button("quiz.button.done") { dismiss() }.font(.system(size: 16))
                }
                Text("quiz.content.list \(quiz.course.wrappedTitle)")
                    .font(.title)
                    .bold()
                    .multilineTextAlignment(.center)

                VStack(spacing: 0) {
                    ForEach(modules.indices, id: \.self) { index in
                        if index == 0 { Divider() }
                        Button {
                            quiz.goToModule(at: index)
                            dismiss()
                        } label: {
                            buttonLabel(for: index)
                        }
                        .foregroundColor(.primary)
                        .background { currentItemBackground(at: index) }
                    }
                }
            }
            .padding()
        }
        .backgroundColorStyle()
        .accessibilityIdentifier(viewName)
    }
}

// MARK: - Helper views

private extension ContentList {
    func buttonLabel(for index: Int) -> some View {
        VStack(alignment: .leading, spacing: 0) {
            Label {
                Text(modules[index].title ?? modules[index].wrappedQuestion )
            } icon: {
                switch modules[index].wrappedCompletionStatus {
                case .skipped:
                    Image(systemName: "checkmark")
                        .opacity(0)
                case .correct:
                    Image(systemName: "checkmark")
                        .foregroundColor(.green)
                case .incorrect:
                    Image(systemName: "xmark")
                        .foregroundColor(.red)
                case .unknown:
                    Image(systemName: "checkmark")
                        .opacity(0)
                }
            }
            .padding(.vertical)
            .padding(.leading, 6)
            Divider()
        }
    }
}

struct ContentList_Previews: PreviewProvider {
    static var previews: some View {
        ContentList()
            .environmentObject(QuizController(course: MockData.courseOne))
    }
}
