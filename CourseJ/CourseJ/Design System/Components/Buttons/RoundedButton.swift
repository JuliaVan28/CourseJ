import SwiftUI

struct RoundedButton: View {
    var title: String
    var width: CGFloat?
    var height: CGFloat = 50.0
    var cornerRadius: CGFloat = 12.0
    var color: Color = .accentColor
    var textColor: Color = .white

    var body: some View {
        RoundedRectangle(cornerRadius: cornerRadius)
            .foregroundColor(color)
            .frame(maxWidth: width, idealHeight: height, maxHeight: height)
            .overlay(Text(title.localized)
                .foregroundColor(textColor)
                .font(.poppinsBodyFixed)
                .fontWeight(.medium))
    }
}

struct RoundedButton_Previews: PreviewProvider {
    static var previews: some View {
        RoundedButton(title: "Title")
    }
}
