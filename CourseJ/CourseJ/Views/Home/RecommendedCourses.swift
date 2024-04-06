

import SwiftUI

struct RecommendedCourses: View {
    @Environment(\.managedObjectContext) private var moc
    @FetchRequest(sortDescriptors: []) var courses: FetchedResults<Course>
    @Binding var isQuizPresented: Bool

   @EnvironmentObject private var dataController: DataController

    var body: some View {
        Group {
            Text("home.recommended")
                .font(.poppinsTitle3)
                .padding(.leading, .Padding)

            ForEach(dataController.courses.filter { $0.rating > 3 }.prefix(3), id: \.self) { course in
                Button {
                    dataController.selectedCourse = course
                    isQuizPresented = true
                } label: {
                    CourseCard(course: course)
                }
                .padding(.horizontal)
            }
        }
        .accessibilityIdentifier(viewName)
    }
}

struct RecommendedCourses_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            RecommendedCourses( isQuizPresented: .constant(false))
        }
        .environmentObject(DataController.shared)
    }
}

