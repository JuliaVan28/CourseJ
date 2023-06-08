import SwiftUI

struct TextFieldWithClearButton: View {
    @Binding var text: String
    var backgroundColor: Color = .ChoiceQuiz.selectedRadioButtonColor

    let callback: (Bool) -> Void

    @Environment(\.dynamicTypeSize) private var typeSize
    private var imageSize: CGFloat { typeSize > .xxxLarge ? 24 : 18 }

    var body: some View {
        HStack {
            TextField("Enter your answer", text: $text)
                .font(.poppinsSubheadline)
                .padding(.vertical)
                .padding(.horizontal, 24.0)
                .frame(minHeight: 48)

                .onChange(of: text) { text in
                    callback(text.isEmpty)
                }
            if text.isNotEmpty {
                Button {
                    text = ""
                } label: {
                    Image(systemName: "multiply.circle.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(height: imageSize)
                        .frame(width: 40, height: 40)
                }
                .foregroundColor(.secondary)
                .padding(.trailing, 10)
                .padding(.leading, -24)
            }
        }
        .background(
            RoundedRectangle(cornerRadius: 12)
                .foregroundColor(backgroundColor)
        )
        .accessibilityIdentifier(viewName)
    }
}

struct TextFieldWithClearButton_Previews: PreviewProvider {
    @State static var textF: String = "hello"

    static var previews: some View {
        TextFieldWithClearButton(text: $textF, backgroundColor: .backgroundColor) { _ in }
    }
}
