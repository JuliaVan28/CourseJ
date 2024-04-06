import SwiftUI

extension View {
    func backgroundColorStyle() -> some View {
        modifier(BackgroundColorModifier())
    }

    func tabBarStyle() -> some View {
        modifier(TabBarModifier())
    }

    func cardStyle(backgroundColor: Color = Color.backgroundColor1, padding: CGFloat? = nil) -> some View {
        modifier(CardStyleModifier(color: backgroundColor, padding: padding))
    }

    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        modifier(CornerRadiusStyle(radius: radius, corners: corners))
    }

    func cardShakeAnimation(isEditing: Bool) -> some View {
        modifier(CardShakeAnimationStyle(isEditing: isEditing))
    }

    var viewName: String { String(describing: Self.self) }
}

// MARK: - BackgroundColor ViewModifiers

private struct BackgroundColorModifier: ViewModifier {
    func body(content: Content) -> some View {
        ZStack {
            Color.backgroundColor.ignoresSafeArea()
            content
        }
    }
}

// MARK: - Card Style ViewModifier

private struct CardStyleModifier: ViewModifier {
    var color: Color
    var padding: CGFloat?
    func body(content: Content) -> some View {
        content
            .padding(.all, padding)
            .background(color)
            .cornerRadius(12)
    }
}

// MARK: - TabBarModifier ViewModifier

private struct TabBarModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.poppinsBody)
            .onAppear(perform: applyTabBarItemStyle)
    }
}

private extension TabBarModifier {
    enum Style {
        static let iconColor = UIColor(Color.secondaryColor)
        static let normalFont = UIFont(name: Font.PoppinsFont.medium.value, size: 11) ?? .systemFont(ofSize: 11)
        static let selectedFont = UIFont(name: Font.PoppinsFont.semiBold.value, size: 11) ?? .boldSystemFont(ofSize: 11)
    }

    func applyTabBarItemStyle() {
        let appearance = UITabBarAppearance()
        let tabBarItemAppearance = UITabBarItemAppearance()
        tabBarItemAppearance.normal.titleTextAttributes = [.foregroundColor: Style.iconColor]
        tabBarItemAppearance.normal.iconColor = Style.iconColor
        tabBarItemAppearance.normal.titleTextAttributes = [.font: Style.normalFont]
        tabBarItemAppearance.selected.titleTextAttributes = [.font: Style.selectedFont]
        appearance.configureWithDefaultBackground()
        appearance.stackedLayoutAppearance = tabBarItemAppearance
        appearance.backgroundColor = UIColor(Color.backgroundColor)
        appearance.shadowColor = UIColor(Color.backgroundColor)
        UITabBar.appearance().standardAppearance = appearance
        UITabBar.appearance().scrollEdgeAppearance = appearance
    }
}

// MARK: - CornerRadiusStyle ViewModifier

private struct CornerRadiusStyle: ViewModifier {
    var radius: CGFloat
    var corners: UIRectCorner

    struct CornerRadiusShape: Shape {
        var radius = CGFloat.infinity
        var corners = UIRectCorner.allCorners

        func path(in rect: CGRect) -> Path {
            Path(
                UIBezierPath(
                    roundedRect: rect,
                    byRoundingCorners: corners,
                    cornerRadii: CGSize(width: radius, height: radius)
                ).cgPath
            )
        }
    }

    func body(content: Content) -> some View {
        content
            .clipShape(CornerRadiusShape(radius: radius, corners: corners))
    }
}

// MARK: - CardShakeAnimation ViewModifier

private struct CardShakeAnimationStyle: ViewModifier {
    var isEditing: Bool

    func body(content: Content) -> some View {
        content
            .rotationEffect(.degrees(isEditing ? 1 : 0), anchor: .top)
            .rotation3DEffect(.degrees(isEditing ? 1 : 0), axis: (x: 0, y: -1, z: 0))
            .animation(.easeInOut(duration: 0.11).repeatAnimation(while: isEditing), value: isEditing)
    }
}
