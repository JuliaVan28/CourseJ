import SwiftUI

struct ArticleImage: View {
    let chapter: ArticleChapter
    private let cornerRadius = 12.0
    
    var body: some View {
        if chapter.image != nil, chapter.image!.isNotEmpty {
            Image(chapter.wrappedImage)
                .resizable()
                .scaledToFit()
                .cornerRadius(cornerRadius)
                .frame(height: 300)
                .accessibilityIdentifier(viewName)
            /*AsyncImage(
             url: URL(string: chapter.image ?? ""),
             transaction: .init(animation: .spring(response: 1.6))
             ) { phase in
             switch phase {
             case .empty:
             ArticleImagePlaceholder(cornerRadius: cornerRadius)
             case let .success(image):
             image
             .resizable()
             .scaledToFit()
             .cornerRadius(cornerRadius)
             default:
             ArticleImagePlaceholder(cornerRadius: cornerRadius)
             }*/
        } else {
            ArticleImagePlaceholder(cornerRadius: cornerRadius)
        }
        
    }
}

struct ArticleImage_Previews: PreviewProvider {
    static var previews: some View {
        ArticleImage(chapter: ArticleChapter())
    }
}
