import SwiftUI

struct CourseCard: View {
    let course: Course

    var body: some View {
        ViewThatFits {
            HStack {
                Image(course.wrappedTitleImage)
                Spacer().frame(width: 34)
                CourseDetails(course: course)
                Spacer()
            }

            VStack {
                Image(course.wrappedTitleImage)
                CourseDetails(course: course)
                HStack { Spacer() }
            }
        }
        .cardStyle(padding: .Padding)
        .accessibilityElement(children: .combine)
        .accessibilityIdentifier(viewName)
    }
}

private struct CourseDetails: View {
    let course: Course

    var body: some View {
        VStack(alignment: .leading) {
            Text(course.wrappedTitle)
                .font(.poppinsSubheadline)
                .fontWeight(.semibold)
                .foregroundColor(.primary)
                .multilineTextAlignment(.leading)
            Label(course.wrappedAuthor, systemImage: "person.fill")
                .font(.poppinsFootnote)
                .foregroundColor(.secondaryColor)
            Text("Rating: \(course.rating)/5")
                .font(.poppinsCaption2)
                .foregroundColor(Color.Progress.progressOrangeColor)
        }
    }
}

struct CourseCard_Previews: PreviewProvider {
    static var previews: some View {
        CourseCard(course: MockData.courseOne)
            .preferredColorScheme(.dark)
    }
}

