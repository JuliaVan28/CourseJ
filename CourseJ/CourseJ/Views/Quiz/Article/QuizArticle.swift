import SwiftUI

struct QuizArticle: View {
    let moduleItem: CourseModule
    let continueAction: () -> Void
    private let spacing = 18.0
    @State private var scrollOffset = CGFloat.zero
    @EnvironmentObject private var quiz: QuizController

    var body: some View {
        ScrollView {
            VStack(spacing: spacing) {
                Text(moduleItem.title ?? "")
                    .font(.poppinsLargeTitle)
                    .multilineTextAlignment(.center)
                ForEach(moduleItem.wrappedArticleChapters) { chapter in
                    VStack(spacing: spacing) {
                        Text(chapter.wrappedTitle)
                            .font(.poppinsTitle)
                            .bold()
                        ArticleImage(chapter: chapter)
                        Text(chapter.wrappedBody)
                            .font(.poppinsBody)
                    }
                }
            }
            .padding(.Padding)
        }
        .safeAreaInset(edge: .bottom) {
            QuizBottomButtonsBar {
                Button {
                    continueAction()
                    let currentModule = quiz.course.modulesArray.firstIndex(of: moduleItem)!
                    quiz.completeModule(at: currentModule, withStatus: true)
                } label: {
                    RoundedButton(title: "quiz.button.continue")
                }
            }
            .accessibilityElement(children: .contain)
        }
        .accessibilityIdentifier(viewName)
    }
}

struct QuizArticle_Previews: PreviewProvider {
    static var previews: some View {
        QuizArticle(moduleItem: CourseModule()) {}
    }
}
