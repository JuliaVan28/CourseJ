import SwiftUI

struct QuizStatsView: View {
    private let spacing = 20.0

    var body: some View {
        VStack {
            ScrollView {
                VStack(spacing: spacing) {
                    Text("quiz.stats.congratulations")
                        .font(.poppinsLargeTitle)
                        .bold()
                    Stars()
                    Text("quiz.stats.youfinished")
                        .font(.poppinsTitle3)
                    Spacer()
                    CompletenessStatus()
                    Spacer()
                }
                .padding(spacing)
            }
            ActionButtons()
                .padding(.horizontal, spacing)
        }
        .backgroundColorStyle()
        .accessibilityIdentifier(viewName)
    }
}

// MARK: - Helper views

private struct Stars: View {
    @EnvironmentObject private var quiz: QuizController
    private func getStarsQuantity() -> Int {
        let percentage = quiz.course.correctModules * 100 / quiz.course.totalModules
        switch percentage {
        case 0 ..< 20: return 1
        case 20 ..< 40: return 2
        case 40 ..< 60: return 3
        case 60 ..< 80: return 4
        default: return 5
        }
    }

    var body: some View {
        HStack {
            ForEach(1 ..< getStarsQuantity(), id: \.self) { _ in
                Image(systemName: "star.fill")
                    .font(.system(size: 35))
                    .foregroundColor(.yellow)
            }
        }
    }
}

private struct CompletenessStatus: View {
    @EnvironmentObject private var quiz: QuizController
    private var completenessStatusColor: Color { quiz.course.isCourseCompleted ? .green : .orange }
    private var completenessStatusIcon: String {
        quiz.course.isCourseCompleted ? "checkmark.seal.fill" : "exclamationmark.triangle.fill"
    }

    private var correctAnswers: some View {
        Group {
            Text("\(quiz.course.correctModules)/\(Int(quiz.course.totalModules))")
            Text("quiz.stats.correctanswers")
        }
    }

    var body: some View {
        Image(systemName: completenessStatusIcon)
            .font(.largeTitle)
            .foregroundColor(completenessStatusColor)
        Text("quiz.stats.yourresults")
            .font(.poppinsTitle3)
            .bold()
        ViewThatFits {
            HStack { correctAnswers }
            VStack { correctAnswers }
        }
    }
}

private struct ActionButtons: View {
    @EnvironmentObject private var quiz: QuizController
    @Environment(\.dismiss) private var dismiss
    @Environment(\.presentationMode) private var presentationMode
    private func dismissQuizSheets() {  presentationMode.wrappedValue.dismiss() }

    var body: some View {
        VStack(spacing: 10) {
            if !quiz.course.isCourseCompleted {
                Button {
                    quiz.resumeCourse()
                    dismiss()
                } label: {
                    RoundedButton(title: "quiz.stats.button.resume")
                }
            }

            Button {
                quiz.completeCourse()
                dismissQuizSheets()
            } label: {
                RoundedButton(title: "quiz.stats.button.complete")
            }

            Button {
                quiz.restartCourse()
                dismiss()
            } label: {
                RoundedButton(title: "quiz.stats.button.restart")
            }
        }
    }
}

struct QuizStatsView_Previews: PreviewProvider {
    static var previews: some View {
        QuizStatsView()
            .environmentObject(QuizController(course: MockData.courseOne))
    }
}
