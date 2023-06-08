import SwiftUI

struct HomeView: View {
    @Environment(\.managedObjectContext) private var moc
    @FetchRequest(sortDescriptors: []) var courses: FetchedResults<Course>
    @EnvironmentObject private var dataController: DataController
    @EnvironmentObject private var theme: AppTheme
    @State private var isQuizPresented = false

    var body: some View {
        NavigationStack {
            ScrollView {
                HomeHeader(userName: "Julia")
                Spacer().frame(height: 80)
                VStack(alignment: .leading, spacing: 15) {

                    HorizontalRollerView(adItems: MockData.homeAdImages)
                    RecommendedCourses(isQuizPresented: $isQuizPresented)

                    Image("Meetup")
                        .resizable()
                        .scaledToFit()
                        .padding(.horizontal, .Padding)
                }
            }
            .backgroundColorStyle()
        }
        .fullScreenCover(isPresented: $isQuizPresented) {
        QuizView(isPresented: $isQuizPresented, course: dataController.selectedCourse!)
        .preferredColorScheme(theme.colorScheme)
        }
        .accessibilityIdentifier(viewName)
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
            .environmentObject(AppTheme())
            .preferredColorScheme(.dark)
    }
}
