import SwiftUI

struct SearchTextFieldView: View {
    var placeholder: Text
    @Binding var text: String

    var body: some View {
        ZStack(alignment: .leading) {
            if text.isEmpty { placeholder }
            TextField("", text: $text)
        }
        .foregroundColor(.secondaryColor)
        .accentColor(.secondaryColor)
    }
}
