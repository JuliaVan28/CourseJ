import SwiftUI

struct HelpView: View {
    var body: some View {
        ScrollView {}
            .backgroundColorStyle()
            .navigationTitle("account.help".localized)
    }
}

struct HelpView_Previews: PreviewProvider {
    static var previews: some View {
        HelpView()
    }
}
