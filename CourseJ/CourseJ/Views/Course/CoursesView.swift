import SwiftUI

struct CoursesView: View {
    @Environment(\.managedObjectContext) private var moc
    @FetchRequest(sortDescriptors: []) var courses: FetchedResults<Course>
    @EnvironmentObject private var dataController: DataController
    @EnvironmentObject private var theme: AppTheme


    @State private var isQuizPresented = false
    @State private var preselectedCategory = Self.CoursesCategoryItem.all
    @State private var filter = CategoryEnum.unknown
    @State private var courseList: [Course] = []


    @State private var text = ""
    @State private var isPresented = false
    
    var body: some View {
        NavigationStack {
            ScrollViewReader { proxy in
                ScrollView {
                    VStack(alignment: .leading) {
                        SearchFieldView(textField: $text, showSheet: $isPresented, scrollProxy: proxy)
                        FilterRollerView(filter: $filter) {
                            courseList = filteredCourses
                        }
                        Text("courses.choose.course".localized)
                            .font(.poppinsTitle3)
                            .fontWeight(.medium)
                            .padding(EdgeInsets(top: 24, leading: 20, bottom: 0, trailing: 0))
                        SegmentedControl(preselectedId: $preselectedCategory) {
                            courseList = sortedCourses
                        }
                        ForEach(courseList, id: \.self) { course in
                            Button {
                                isQuizPresented = true
                                dataController.selectedCourse = course
                            } label: {
                                CourseCard(course: course)
                            }
                            .padding(.horizontal)
                        }
                        Spacer()
                    }
                }
            }
            .navigationTitle(TabBarItemScreen.courses.displayName)
            .backgroundColorStyle()
        }
        .onAppear(perform: initializeCourseList)
        .fullScreenCover(isPresented: $isQuizPresented) {
        QuizView(isPresented: $isQuizPresented, course: dataController.selectedCourse!)
                .preferredColorScheme(theme.colorScheme)
        }
        .accessibilityIdentifier(viewName)
    }
}

// TODO: decouple CoursesCategoryItem from this view
extension CoursesView {
    enum CoursesCategoryItem: String, CaseIterable, Identifiable {
        var id: String { rawValue }

        case all
        case popular
        case new
        case name

        var displayName: String {
            switch self {
            case .all: return "courses.category.all".localized
            case .popular: return "courses.category.popular".localized
            case .new: return "courses.category.new".localized
            case .name: return "courses.category.name".localized
            }
        }
    }
    
    private func initializeCourseList() {
            courseList = Array(courses)
        }
    
    private var sortedCourses: [Course] {
            switch preselectedCategory {
            case .all:
                return Array(courses)
            case .popular:
                return Array(courses.sorted { $0.rating > $1.rating })
            case .new:
                return Array(courses.sorted { $0.createdAt ?? Date() > $1.createdAt ?? Date() })
            case .name:
                return Array(courses.sorted { $0.wrappedTitle < $1.wrappedTitle })
            }
        }
    
    private var filteredCourses: [Course] {
        switch filter {
        case .unknown:
            return Array(courses)
        case .language:
            return Array(courses.filter({$0.wrappedCategory.category == .language}))
        case .painting:
            return Array(courses.filter({$0.wrappedCategory.category == .painting}))
        case .coding:
            return Array(courses.filter({$0.wrappedCategory.category == .coding}))
        case .design:
            return Array(courses.filter({$0.wrappedCategory.category == .design}))
        }
    }
}

struct CoursesView_Previews: PreviewProvider {
    static var previews: some View {
        CoursesView()
        .environmentObject(DataController.shared)
        .environmentObject(AppTheme())
        .preferredColorScheme(.dark)
    }
}
