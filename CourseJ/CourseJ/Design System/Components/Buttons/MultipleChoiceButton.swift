import SwiftUI

struct MultipleChoiceButton: View {
    @Binding var selectedOptions: [String]
    @Binding var buttonColor: Color
    let option: String

    private let height: CGFloat = 54.0
    private let cornerRadius: CGFloat = 3.0
    @EnvironmentObject private var module: ChoiceModulesController
    @Environment(\.dynamicTypeSize) private var typeSize

    var body: some View {
        Button {
            updateSelectedOptions(with: option)
        } label: {
            AccessibleLayoutView {
                HStack(spacing: 17) {
                    Image(buttonIcon)
                        .frame(width: 34, height: 34)
                    Text(option)
                        .font(.poppinsBody)
                        .multilineTextAlignment(.leading)
                    Spacer()
                }
            } accessibleLayout: {
                VStack {
                    Image(buttonIcon)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 50, height: 50)
                    Text(option)
                        .font(.poppinsBody)
                        .multilineTextAlignment(.leading)
                    HStack { Spacer() }
                }
                .padding(.top, 4)
            }
            .padding()
        }
        .frame(minHeight: height)
        .background(isSelected ? buttonColor : Color.Filter.buttonColor)
        .foregroundColor(Color.Filter.buttonTextColor)
        .cornerRadius(cornerRadius)
        .accessibilityIdentifier(viewName)
    }
}

// MARK: MultipleChoiceButton view logic

private extension MultipleChoiceButton {
    var isSelected: Bool { selectedOptions.contains(option) ? true : false }
    var buttonIcon: String { isSelected ? "сheckBoxWithCheck" : "сheckBoxEmpty" }
    var isAccessibilityTypeSize: Bool { typeSize > .xxxLarge }
    func updateSelectedOptions(with selectedOption: String) {
        if selectedOptions.contains(selectedOption) {
            selectedOptions.remove(at: selectedOptions.firstIndex(of: selectedOption) ?? 0)
        } else {
            selectedOptions.append(selectedOption)
        }
        module.config.isSubmitDisabled = selectedOptions.isEmpty
    }
}

struct MultipleChoiceButton_Previews: PreviewProvider {
    static var option: String = "Option"
    @State private static var selectedOptions: [String] = []
    @State private static var buttonColor: Color = .backgroundColor

    static var previews: some View {
        MultipleChoiceButton(
            selectedOptions: $selectedOptions,
            buttonColor: $buttonColor,
            option: option
        )
        .previewLayout(.sizeThatFits)
    }
}
