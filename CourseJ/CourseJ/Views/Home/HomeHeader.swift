import SwiftUI

struct HomeHeader: View {
    let userName: String

    var body: some View {
        GeometryReader { geo in
            Color.accentColor
                .frame(height: 630)
                .position(x: geo.size.width / 2, y: -200)
                .accessibilityElement(children: .ignore)
        }
        .accessibilityHidden(true)
        .overlay(alignment: .top) {
            HStack(alignment: .top) {
                VStack(alignment: .leading) {
                    Text("home.hello \(userName)")
                        .font(.poppinsTitleFixed)
                        .fontWeight(.semibold)
                    Text("home.letsStart")
                        .font(.poppinsSubheadlineFixed)
                }
                .foregroundColor(.white)

                Spacer()

                Image("avatarCourses")
            }
            .padding(.horizontal, .Padding)
            .padding(.top, 10)
            .accessibilityElement(children: .combine)
            .accessibilityIdentifier(viewName)
        }
    }
}

struct HomeHeader_Previews: PreviewProvider {
    static var previews: some View {
        ScrollView {
            HomeHeader(userName: "Jake")
        }
    }
}
