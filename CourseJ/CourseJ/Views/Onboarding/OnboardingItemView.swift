import SwiftUI

struct OnboardingItemView: View {
    var title: String
    var imageName: String

    var body: some View {
        VStack {
            Spacer(minLength: 50.0)
            Image(imageName)
                .resizable()
                .scaledToFit()
                .padding(.horizontal, 50.0)
            Spacer(minLength: 50.0)
            Text(title)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 80.0)
        }
        .accessibilityIdentifier(viewName)
    }
}

struct OnboardingItemView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingItemView(title: "Text", imageName: "illustration1")
    }
}
