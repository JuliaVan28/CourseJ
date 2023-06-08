import SwiftUI

struct SegmentedControl: View {
    @Binding var preselectedId: CoursesView.CoursesCategoryItem
    private func foregroundColor(for category: CoursesView.CoursesCategoryItem) -> Color {
        preselectedId.id == category.id ? .white : .Filter.buttonTextColor
    }

    private func backgroundColor(for category: CoursesView.CoursesCategoryItem) -> Color {
        preselectedId.id == category.id ? .accentColor : .Filter.buttonColor
    }

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 15) {
                ForEach(CoursesView.CoursesCategoryItem.allCases) { category in
                    Button {
                        preselectedId = category
                    } label: {
                        Text(category.displayName)
                    }
                    .padding(.horizontal)
                    .frame(minWidth: 73, minHeight: 28)
                    .font(.poppinsSubheadline)
                    .foregroundColor(foregroundColor(for: category))
                    .background(backgroundColor(for: category))
                    .animation(.easeInOut(duration: 0.3), value: preselectedId == category)
                    .clipShape(Capsule())
                    .accessibilityElement(children: .combine)
                    .accessibilityIdentifier(viewName)
                }
            }.padding(.leading, .Padding)
            .padding(.bottom, 15)
        }
    }
}

struct SegmentedController_Previews: PreviewProvider {
    static var previews: some View {
        SegmentedControl(preselectedId: .constant(CoursesView.CoursesCategoryItem.all)).previewLayout(.sizeThatFits)
    }
}
