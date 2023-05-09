import SwiftUI

struct OnboardingView: View {
    @Binding var shouldShowOnboarding: Bool
    @State private var pageIndex = 0
    private let onboardingItems = OnboardingItem.items

    var body: some View {
        VStack {
            TabView(selection: $pageIndex) {
                ForEach(onboardingItems.indices, id: \.self) { index in
                    OnboardingItemView(
                        title: onboardingItems[index].title,
                        imageName: onboardingItems[index].imageName
                    )
                }
            }
            .tabViewStyle(.page(indexDisplayMode: .never))
            Spacer(minLength: 30.0)
            PageIndicator(pageIndex: $pageIndex, pagesCount: onboardingItems.count)
            Spacer(minLength: 80.0)
            Button {
                shouldShowOnboarding.toggle()
            } label: {
                RoundedButton(title: "onboarding.login", width: 160)
            }
            Spacer(minLength: 40.0)
        }
        .font(.poppinsBody)
        .background(Color.backgroundColor)
        .accessibilityIdentifier(viewName)
    }
}


struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView(shouldShowOnboarding: .constant(true))
    }
}
