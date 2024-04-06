
import SwiftUI

struct RemoveCourseButton: View {
    var isEditing: Bool
    @Environment(\.dynamicTypeSize) private var fontSize
    private var iconColor: Color { isEditing ? .black : .clear }
    private var iconScale: CGFloat { fontSize <= .large ? 0.7 : 0.6 }
    private var backgroundLayer1: Color { .gray.opacity(isEditing ? 0.4 : 0) }
    private var backgroundLayer2: some ShapeStyle { .ultraThinMaterial.opacity(isEditing ? 1 : 0) }

    var body: some View {
        ZStack {
            Circle()
                .foregroundColor(backgroundLayer1)
                .background(backgroundLayer2)
                .frame(height: 25)
                .clipShape(Circle())
            Image(systemName: "poweron")
                .font(.system(size: 20, weight: .bold))
                .rotationEffect(.degrees(90))
                .foregroundColor(iconColor)
                .scaleEffect(iconScale)
        }
        .padding(24)
        .transition(.opacity)
        .animation(.default, value: isEditing)
    }
}

struct RemoveCourseButton_Previews: PreviewProvider {
    static var previews: some View {
        RemoveCourseButton(isEditing: true)
    }
}

