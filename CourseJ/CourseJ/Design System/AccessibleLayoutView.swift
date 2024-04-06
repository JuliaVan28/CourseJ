import SwiftUI

struct AccessibleLayoutView<NormalContent, AccessibleContent>: View where NormalContent: View, AccessibleContent: View {
    let normalLayout: NormalContent
    let accessibleLayout: AccessibleContent

    @Environment(\.dynamicTypeSize) private var typeSize

    init(@ViewBuilder normalLayout: () -> NormalContent, @ViewBuilder accessibleLayout: () -> AccessibleContent) {
        self.normalLayout = normalLayout()
        self.accessibleLayout = accessibleLayout()
    }

    var body: some View {
        Group {
            if typeSize > .xxxLarge {
                accessibleLayout
            } else {
                normalLayout
            }
        }
    }
}

struct AccessibleLayoutView_Previews: PreviewProvider {
    static var previews: some View {
        AccessibleLayoutView {
            HStack {
                Text("Hello")
                Text("World")
            }
        } accessibleLayout: {
            VStack {
                Text("Hello")
                Text("World")
            }
        }
    }
}
