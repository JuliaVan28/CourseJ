import SwiftUI

struct MyCoursesView: View {
    @EnvironmentObject private var user: User
   @EnvironmentObject private var dataController: DataController

    var body: some View {
        NavigationStack {
            Group {
                if user.usersCoursesArray.isEmpty {
                    VStack {
                        Image("myCoursesEmpty")
                        Text("mycourses.nocourses")
                            .font(.poppinsFootnote)
                            .foregroundColor(.secondaryColor)
                    }
                } else {
                    CurrentlyLearningView(courses: $dataController.courses)
                }
            }
            .navigationTitle(TabBarItemScreen.myCourses.displayName)
            .navigationBarTitleDisplayMode(.inline)
            .backgroundColorStyle()
            .toolbar { if !user.usersCoursesArray.isEmpty { EditButton() } }
        }
        .accessibilityIdentifier(viewName)
    }
}

struct MyCoursesView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            MyCoursesView()
                .previewDisplayName("some courses in my courses")
            MyCoursesView()
                .previewDisplayName("No courses in my courses")
        }
        .environmentObject(DataController.shared)
    }
}

