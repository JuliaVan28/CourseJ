import SwiftUI

struct RadioButton: View {
    let option: String
    @Binding var selectedOption: String
    @Binding var buttonColor: Color

    private let outerCircleColor: Color = .ChoiceQuiz.outerCircleButtonColor
    private let innerCircleColor: Color = .ChoiceQuiz.innerCircleButtonColor
    private let backgroundColor: Color = .Filter.buttonColor
    private let textColor: Color = .Filter.buttonTextColor
    private let height: CGFloat = 54.0
    private let cornerRadius: CGFloat = 3.0
    @EnvironmentObject private var module: ChoiceModulesController

    var body: some View {
        Button {
            selectedOption = option
            module.config.isSubmitDisabled = false
        } label: {
            AccessibleLayoutView {
                HStack(spacing: 17) {
                    ZStack {
                        if selectedOption == option {
                            Circle().stroke(outerCircleColor, lineWidth: 8)
                                .frame(height: 25)
                            Circle().fill(innerCircleColor)
                                .frame(height: 18)
                        } else {
                            Circle().stroke(outerCircleColor, lineWidth: 3)
                                .frame(height: 25)
                        }
                    }
                    Text(option)
                        .font(.poppinsBody)
                        .multilineTextAlignment(.leading)
                    Spacer()
                }
                .padding(.leading, 22)
                .padding(.trailing)
                .padding(.vertical)
            } accessibleLayout: {
                VStack {
                    ZStack {
                        if selectedOption == option {
                            Circle().stroke(outerCircleColor, lineWidth: 10)
                                .frame(height: 33)
                            Circle().fill(innerCircleColor)
                                .frame(height: 28)
                        } else {
                            Circle().stroke(outerCircleColor, lineWidth: 3)
                                .frame(height: 33)
                        }
                    }
                    Text(option)
                        .font(.poppinsBody)
                        .multilineTextAlignment(.leading)
                    HStack { Spacer() }
                }
                .padding(.top, 26)
                .padding(.bottom)
                .padding(.horizontal)
            }
        }
        .frame(minHeight: height)
        .background(selectedOption == option ? buttonColor : backgroundColor)
        .foregroundColor(textColor)
        .cornerRadius(cornerRadius)
        .accessibilityIdentifier(viewName)
    }
}

// MARK: RadioButtonGroup

struct RadioButtonGroup: View {
    let options: [String]
    @Binding var selectedOption: String
    @Binding var buttonColor: Color
    @Binding var isDisabled: Bool

    var body: some View {
        VStack(spacing: 2) {
            ForEach(options, id: \.self) { option in
                RadioButton(
                    option: option,
                    selectedOption: $selectedOption,
                    buttonColor: $buttonColor
                )
                .disabled(isDisabled)
            }
        }
    }
}

struct RadioButton_Previews: PreviewProvider {
    static var moduleItem = CourseModule()

    static var previews: some View {
        RadioButtonGroup(
            options: moduleItem.wrappedAnswers.map{$0.wrappedAnswer},
            selectedOption: .constant(""),
            buttonColor: .constant(.backgroundColor),
            isDisabled: .constant(true)
        )
        .previewLayout(.sizeThatFits)
    }
}
