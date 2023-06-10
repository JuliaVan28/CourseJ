import SwiftUI

struct CurrentlyLearningView: View {
    @Binding var courses: [Course]
    @Environment(\.dynamicTypeSize) private var typeSize
    private let gridSpacing: CGFloat = 20

    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                LazyVGrid(columns: columnsLayout, spacing: gridSpacing) {
                    
                    ForEach(Array(courses.enumerated()), id: \.element) { index, item in
                        CourseCardWithProgress(course: item) {
                            withAnimation { removeCourse(at: index) }
                        }
                        .transition(.scale)
                    }
                }
            }
            .padding()
        }
        .accessibilityIdentifier(viewName)
    }
}

// MARK: - View logic

private extension CurrentlyLearningView {
    var columnsLayout: [GridItem] {
        typeSize > .xxxLarge ? [GridItem()] : [GridItem(spacing: gridSpacing), GridItem()]
    }

    func removeCourse(at index: Int) { courses[index].isReset = true }
}

struct CurrentlyLearningView_Previews: PreviewProvider {
    @State static var courses = [MockData.courseOne]
    

    static var previews: some View {
        ScrollView { CurrentlyLearningView(courses: .constant(courses))}
            .previewDisplayName("LTR CurrentlyLearningView")

        ScrollView { CurrentlyLearningView(courses: .constant(courses))}
            .environment(\.layoutDirection, .rightToLeft)
            .previewDisplayName("RTL CurrentlyLearningView")
    }
}

