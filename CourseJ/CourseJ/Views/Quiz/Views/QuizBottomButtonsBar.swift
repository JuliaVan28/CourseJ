import SwiftUI

struct QuizBottomButtonsBar<Content>: View where Content: View {
    let content: Content

    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }

    var body: some View {
        VStack { content }
            .padding(.top, .Padding)
            .padding(.horizontal, .Padding)
            .padding(.bottom, 6)
            .background(Color.backgroundColor)
            .accessibilityIdentifier(viewName)
    }
}

struct QuizBottomButtonsBar_Previews: PreviewProvider {
    static var previews: some View {
        QuizBottomButtonsBar {
            Text("Hi")
            Text("There")
        }
    }
}
