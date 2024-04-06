import SwiftUI

struct ResumeLearningButton: View {
    var category: CategoryEnum?
    var isDisabled = false
    @Environment(\.layoutDirection) private var layoutDirection
    @Environment(\.dynamicTypeSize) private var typeSize

    /// Button color is selected for the category
    init(category: CategoryEnum) { self.category = category }
    /// Button is active with accent color or can be disabled with lock icon
    init(isDisabled: Bool = false) { self.isDisabled = isDisabled }

    var body: some View {
        ZStack {
            Circle()
                .foregroundColor(buttonColor)
                .frame(height: buttonSize)
            Image(buttonIcon)
                .resizable()
                .frame(width: iconSize, height: iconSize)
                .foregroundColor(.white)
                .offset(x: xIconOffset)
        }
        .accessibilityIdentifier(viewName)
    }
}

// MARK: - ResumeLearningButton view logic

private extension ResumeLearningButton {
    var buttonColor: Color { CategoryEnum.color(for: category).opacity(isDisabled ? 0.3 : 1) }
    var buttonIcon: String { isDisabled ? "lock" : "playButton" }
    var xIconOffset: CGFloat {
        if isDisabled { return 0 }
        return layoutDirection == .rightToLeft ? -2 : 2
    }

    var iconSize: CGFloat { buttonSize / 3.2 }
    var buttonSize: CGFloat {
        var size: CGFloat = 44
        if typeSize < .medium { size = 36 }
        if typeSize > .xxxLarge { size = 60 }

        return size
    }
}

struct ResumeLearningButton_Previews: PreviewProvider {
    static var previews: some View {
        HStack {
            ResumeLearningButton()
            ResumeLearningButton(category: CategoryEnum.painting)
            ResumeLearningButton(category: CategoryEnum.coding)
            ResumeLearningButton(isDisabled: true)
        }
        .previewLayout(.sizeThatFits)
    }
}
