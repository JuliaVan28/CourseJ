import SwiftUI

struct SearchFieldView: View {
    @Binding var textField: String
    @Binding var showSheet: Bool
    var scrollProxy: ScrollViewProxy

    var body: some View {
        VStack {
            HStack {
                Spacer()
                Image("search")
                    .padding(.trailing, 4)
                SearchTextFieldView(placeholder: Text("Find Course"), text: $textField)
                    .font(.poppinsSubheadline)
                Button {
                    withAnimation(.linear(duration: 0.1)) {
                        scrollProxy.scrollTo("Search", anchor: .center)
                        self.showSheet = true
                    }
                } label: {
                    Image("filter")
                        .padding(.trailing, 6)
                }
                Spacer()
            }
            .padding(EdgeInsets(top: 12, leading: 8, bottom: 12, trailing: 2))
            .background(Color.backgroundColor2)
            .cornerRadius(12)
            .padding(.horizontal)
        }
        .accessibilityElement(children: .combine)
        .accessibilityIdentifier(viewName)
    }
}
