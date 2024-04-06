import SwiftUI

extension Font {
    enum PoppinsFont {
        case bold
        case light
        case medium
        case semiBold
        case regular
        case custom(String)

        var value: String {
            switch self {
            case .bold: return "Poppins-Bold"
            case .light: return "Poppins-Light"
            case .medium: return "Poppins-Medium"
            case .semiBold: return "Poppins-SemiBold"
            case .regular: return "Poppins-Regular"
            case let .custom(name): return name
            }
        }
    }

    // MARK: Custom Fonts

    static func poppins(_ size: CGFloat, type: PoppinsFont = .regular, relativeTo: TextStyle = .body) -> Font {
        .custom(type.value, size: size, relativeTo: relativeTo)
    }

    static let poppinsLargeTitle = poppins(32, relativeTo: .largeTitle)
    static let poppinsTitle = poppins(24, relativeTo: .title)
    static let poppinsTitleFixed = Font.custom(PoppinsFont.regular.value, fixedSize: 24)
    static let poppinsTitle2 = poppins(20, relativeTo: .title2)
    static let poppinsTitle3 = poppins(18, relativeTo: .title3)
    static let poppinsHeadline = poppins(16, type: .semiBold, relativeTo: .headline)
    static let poppinsBody = poppins(16, relativeTo: .body)
    static let poppinsBodyFixed = Font.custom(PoppinsFont.regular.value, fixedSize: 16)
    static let poppinsCallout = poppins(15, relativeTo: .callout)
    static let poppinsSubheadline = poppins(14, relativeTo: .subheadline)
    static let poppinsSubheadlineFixed = Font.custom(PoppinsFont.regular.value, fixedSize: 14)
    static let poppinsFootnote = poppins(12, relativeTo: .footnote)
    static let poppinsCaption = poppins(11, relativeTo: .caption)
    static let poppinsCaption2 = poppins(10, relativeTo: .caption2)
}
