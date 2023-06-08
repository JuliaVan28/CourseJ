import SwiftUI

struct TextFieldWithTitle: View {
    let title: String
    @Binding var text: String

    var body: some View {
        Text(title)
            .font(.poppinsSubheadline)
            .foregroundColor(.Login.textColor)
            .frame(height: 21)
            .padding(.top, 24.0)
        TextField("", text: $text)
            .font(.poppinsSubheadline)
            .padding(.top, 1.0)
            .padding(.horizontal, 24.0)
            .frame(height: 50)
            .background(RoundedRectangle(cornerRadius: 12)
                .foregroundColor(.backgroundColor2))
    }
}

struct TextFieldWithTitle_Previews: PreviewProvider {
    static var previews: some View {
        TextFieldWithTitle(title: "Title", text: .constant("Text"))
    }
}
