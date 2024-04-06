import SwiftUI

struct HorizontalRollerView: View {
    let adItems: [AdImage]

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(alignment: .center, spacing: 15) {
                ForEach(adItems) { item in
                    Button {} label: {
                        Image(item.image)
                    }
                }
            }
            .padding(.leading, .Padding)
            .accessibilityIdentifier(viewName)
        }
    }
}

struct HorizontalRollerView_Previews: PreviewProvider {
    static var previews: some View {
        HorizontalRollerView(adItems: MockData.adImages)
            .previewLayout(.sizeThatFits)
    }
}
