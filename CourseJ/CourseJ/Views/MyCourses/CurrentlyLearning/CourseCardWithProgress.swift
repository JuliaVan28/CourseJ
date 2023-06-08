import SwiftUI

struct CourseCardWithProgress: View {
    var course: Course
    var action: () -> Void
    @Environment(\.editMode) private var editMode
    @Environment(\.colorScheme) private var colorScheme

    var body: some View {
        ZStack(alignment: .topTrailing) {
            CardContent(course: course)
                .cardStyle(backgroundColor: cardBackgroundColor)
                .accessibilityElement(children: .combine)
                .onTapGesture {}
                .onLongPressGesture {
                    activateEditing()
                    hapticSuccessFeedback()
                }
            Button(action: action) { RemoveCourseButton(isEditing: inEditingMode) }
                .offset(x: 30, y: -30)
                .opacity(buttonOpacity)
                .animation(nil, value: inEditingMode)
        }
        .cardShakeAnimation(isEditing: inEditingMode)
        .accessibilityIdentifier(viewName)
    }
}

// MARK: - CourseCardWithProgress view logic

private extension CourseCardWithProgress {
    var buttonOpacity: Double { inEditingMode ? 1 : 0 }
    var inEditingMode: Bool { editMode?.wrappedValue == .active }
    func activateEditing() { editMode?.wrappedValue = .active }
    func hapticSuccessFeedback() {
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(.success)
    }

    var cardBackgroundColor: Color {
        colorScheme == .light
        ? CategoryEnum.color(for: course.wrappedCategory.category).opacity(0.2)
            : .backgroundColor1
    }
}

struct CourseCardWithProgress_Previews: PreviewProvider {
    static var previews: some View {
        ScrollView {
            CourseCardWithProgress(course: MockData.courseOne) {}
        }
    }
}

