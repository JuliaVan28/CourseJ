import SwiftUI

struct TabBarView: View {
    @EnvironmentObject var theme: AppTheme

    var body: some View {
        TabView {
            ForEach(TabBarItem.allCases) { screen in
                /*Group {
                    switch screen {
                    case .home: HomeView(courses: coursesStore.courses)
                    case .courses: CoursesView()
                    case .myCourses: MyCoursesView()
                    case .account: AccountView()
                    }
                }
                .tabItem { screen.label }.tag(screen)
                 */
            }
        }
        .tabBarStyle()
        .preferredColorScheme(theme.colorScheme)
        .accessibilityIdentifier(viewName)
    }
}

struct TabBarView_Previews: PreviewProvider {
    static var previews: some View {
        TabBarView()
            .environmentObject(AppTheme())
    }
}
