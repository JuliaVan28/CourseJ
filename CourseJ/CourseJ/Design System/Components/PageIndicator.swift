//
//  PageIndicator.swift
//  CourseJ
//
//  Created by Julia Vanchytska on 08.05.2023.
//

import SwiftUI

struct PageIndicator: View {
    @Binding var pageIndex: Int
    var pagesCount = 0

    var body: some View {
        HStack(spacing: 10.0) {
            ForEach(0 ..< pagesCount, id: \.self) { index in
                Capsule()
                    .fill(pageIndex == index ? Color.accentColor : Color.Button.inactiveButton)
                    .frame(width: pageIndex == index ? 28.0 : 9.0, height: 5.0)
                    .animation(.easeInOut(duration: 0.3), value: pageIndex == index)
            }
        }
        .accessibilityIdentifier(viewName)
    }
}

struct PageIndicator_Previews: PreviewProvider {
    static var previews: some View {
        PageIndicator(pageIndex: .constant(0), pagesCount: 3)
    }
}
