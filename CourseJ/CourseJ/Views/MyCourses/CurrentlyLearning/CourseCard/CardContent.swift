import SwiftUI

struct CardContent: View {
    var course: Course
    @EnvironmentObject private var theme: AppTheme
    @State private var isQuizPresented = false
    @EnvironmentObject private var dataController: DataController
    private var currentCourse: Course { dataController.courses.first { $0.courseId == course.courseId }! }

    var body: some View {
        VStack(alignment: .leading) {
            Text(course.wrappedTitle)
                .fontWeight(.heavy)
                .lineLimit(2)
                .frame(minHeight: 48, alignment: .topLeading)
                .accessibilitySortPriority(3)
            Spacer()
            ProgressBar(
                value: course.progressValue,
                total: course.progressTotal,
                indicatorColor: CategoryEnum.color(for: course.wrappedCategory.category),
                trackColor: .white,
                softGradient: false
            )
            Text("mycourses.completed")
                .font(.footnote)
                .foregroundColor(.secondaryColor)
                .accessibilitySortPriority(1)
            HStack {
                CompletedTopics(course: course)
                    .accessibilitySortPriority(2)
                Spacer()
                Button {
                    isQuizPresented = true
                } label: {
                    ResumeLearningButton(category: course.wrappedCategory.category)
                }
            }
        }
        .padding(.top)
        .fixedSize(horizontal: false, vertical: true)
        .accessibilityElement(children: .combine)
        .fullScreenCover(isPresented: $isQuizPresented) {
        QuizView(isPresented: $isQuizPresented, course: currentCourse)
                .preferredColorScheme(theme.colorScheme)
        }
        .accessibilityIdentifier(viewName)
    }
}

struct CardContent_Previews: PreviewProvider {
    static var previews: some View {
        CardContent(course: MockData.courseOne)
    }
}

