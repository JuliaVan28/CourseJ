import SwiftUI

struct TabBarView: View {
    @EnvironmentObject var theme: AppTheme
    @Environment(\.managedObjectContext) private var moc

    @EnvironmentObject var dataController: DataController
    private var persistenceController: PersistenceController
    
    init(persistenceController: PersistenceController) {
        self.persistenceController = persistenceController
    }

    var body: some View {
        TabView {
            ForEach(TabBarItem.allCases) { screen in
                Group {
                    switch screen {
                    case .home: HomeView()
                            .onAppear(perform: dataController.loadDataBase)
                    case .courses: CoursesView()
                    case .myCourses: MyCoursesView()
                    case .account: AccountView()
                    }
                }
                .tabItem { screen.label }.tag(screen)
                 
            }
        }
        .tabBarStyle()
        .preferredColorScheme(theme.colorScheme)
        .accessibilityIdentifier(viewName)
    }
}

enum TabBarItemScreen: String, CaseIterable, Identifiable {
    var id: String { rawValue }

    case home
    case courses
    case myCourses
    case account

    var displayName: String {
        switch self {
        case .home: return "tab.item.title.home".localized
        case .courses: return "tab.item.title.courses".localized
        case .myCourses: return "tab.item.title.myCourses".localized
        case .account: return "tab.item.title.account".localized
        }
    }

    var image: String {
        switch self {
        case .home: return "home"
        case .courses: return "courses"
        case .myCourses: return "myCourses"
        case .account: return "account"
        }
    }

    var label: Label<Text, Image> {
        Label(displayName, image: image)
    }
}
struct TabBarView_Previews: PreviewProvider {
    static var previews: some View {
        TabBarView(persistenceController: PersistenceController.shared)
            .environmentObject(AppTheme())
    }
}
