import SwiftUI

struct ProgressBar: View {
    var value: CGFloat
    var total: CGFloat = 1.0
    var indicatorColor = Color.Progress.progressOrangeColor
    var trackColor = Color.Progress.progressTrackColor
    var softGradient = true

    private let cornerRadius = 22.0
    private let height = 6.0
    private let flipsRTL = true

    var body: some View {
        GeometryReader { geo in
            ZStack(alignment: .leading) {
                RoundedRectangle(cornerRadius: cornerRadius, style: .continuous)
                    .frame(width: geo.size.width, height: height)
                    .foregroundColor(trackColor)
                RoundedRectangle(cornerRadius: cornerRadius, style: .continuous)
                    .frame(width: calculateIndicatorWidth(for: geo), height: height)
                    .foregroundColor(.clear)
                    .background(
                        LinearGradient(
                            stops: calculateGradientStops(with: progress, soften: softGradient),
                            startPoint: .leading,
                            endPoint: .trailing
                        )
                        .cornerRadius(cornerRadius, corners: indicatorCorners)
                    )
            }
        }
        .frame(height: 6)
        .flipsForRightToLeftLayoutDirection(flipsRTL)
        .accessibilityIdentifier(viewName)
    }
}

// MARK: ProgressBar view logic

private extension ProgressBar {
    var progress: CGFloat {
        let progress = value / total
        switch progress {
        case _ where progress > 1: return 1
        case _ where progress < 0: return 0
        default: return progress
        }
    }

    var indicatorCorners: UIRectCorner {
        if progress > 0.99 { return [.topRight, .bottomRight, .topLeft, .bottomLeft] }
        return flipsRTL ? [.topLeft, .bottomLeft] : [.topRight, .bottomRight]
    }

    func calculateIndicatorWidth(for geometry: GeometryProxy) -> CGFloat { progress * geometry.size.width }

    func calculateGradientStops(with progress: CGFloat, soften: Bool) -> [Gradient.Stop] {
        struct StopConfig { let opacity, location: CGFloat }

        let startStop = StopConfig(opacity: soften ? 0.0 : 0.2, location: 0.0)
        let midStop = StopConfig(opacity: progress / 3, location: progress / 1.2)
        let endStop = StopConfig(opacity: 1, location: 1)

        let stops = [
            startStop,
            soften ? midStop : nil,
            endStop,
        ]
        .compactMap { $0 }
        .map { Gradient.Stop(color: indicatorColor.opacity($0.opacity), location: $0.location) }

        return stops
    }
}

struct ProgressBar_Previews: PreviewProvider {
    static var previews: some View {
        ProgressBar(value: 0.99)
            .padding()
    }
}
