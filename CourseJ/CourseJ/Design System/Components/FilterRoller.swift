import SwiftUI

struct FilterRollerView: View {
    @Binding var filter: CategoryEnum
    let setFilterCourses: () -> Void
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(alignment: .center, spacing: 15) {
                ForEach(CategoryEnum.allCases) { item in
                    Button {
                        filter = item
                        setFilterCourses()
                    } label: {
                        item.image
                    }
                }
            }
            .padding(.leading, .Padding)
            .accessibilityIdentifier(viewName)
        }
    }
}

struct FilterRollerView_Previews: PreviewProvider {
    static var previews: some View {
        FilterRollerView(filter: .constant(CategoryEnum.unknown), setFilterCourses: {})
            .previewLayout(.sizeThatFits)
    }
}
