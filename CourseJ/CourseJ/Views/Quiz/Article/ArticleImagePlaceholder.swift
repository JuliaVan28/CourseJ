import SwiftUI

struct ArticleImagePlaceholder: View {
    let cornerRadius: Double

    var body: some View {
        RoundedRectangle(cornerRadius: cornerRadius)
            .fill(LinearGradient(
                colors: [.backgroundColor2, .secondaryColor],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            ))
            .aspectRatio(CGSize(width: 400, height: 300), contentMode: .fit)
            .accessibilityIdentifier(viewName)
    }
}

struct ArticleImagePlaceholder_Previews: PreviewProvider {
    static var previews: some View {
        ArticleImagePlaceholder(cornerRadius: 12)
    }
}
