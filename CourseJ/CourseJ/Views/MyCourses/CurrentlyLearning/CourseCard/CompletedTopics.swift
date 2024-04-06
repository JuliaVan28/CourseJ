import SwiftUI

struct CompletedTopics: View {
    var course: Course

    var body: some View {
        HStack(alignment: .firstTextBaseline, spacing: 0) {
            Text(course.doneModules.formatted())
                .font(.poppinsTitle2)
                .fontWeight(.semibold)
            Group {
                Text("/")
                    .accessibilityLabel(Text("mycourses.accessibility.of"))
                Text(course.totalModules.formatted())
                    .fontWeight(.semibold)
            }
            .font(.poppinsFootnote)
        }
    }
}

struct CompletedTopics_Previews: PreviewProvider {
    static var previews: some View {
        CompletedTopics(course: MockData.courseOne)
            .previewLayout(.sizeThatFits)
    }
}

