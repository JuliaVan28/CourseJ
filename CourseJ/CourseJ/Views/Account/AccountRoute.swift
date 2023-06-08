import SwiftUI

struct AccountRoute<Destination>: View where Destination: View {
    private let title: String
    @ViewBuilder private let destination: () -> Destination

    init(_ title: String, destination: @escaping () -> Destination) {
        self.title = title
        self.destination = destination
    }

    var body: some View {
        NavigationLink(destination: destination) {
            HStack {
                Text(title)
                    .foregroundColor(.primary)
                    .fontWeight(.medium)
                    .multilineTextAlignment(.leading)
                Spacer()
                Image(systemName: "chevron.right")
                    .font(.poppinsCaption)
                    .foregroundColor(.secondary)
            }
            .padding(.vertical, 10)
            .padding(.horizontal)
            .accessibilityElement(children: .combine)
        }
    }
}

struct SettingsNavLink_Previews: PreviewProvider {
    static var previews: some View {
        AccountRoute("Privacy") { Text("Privacy") }
            .previewLayout(.sizeThatFits)
    }
}
