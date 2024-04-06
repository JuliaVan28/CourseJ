import SwiftUI

extension Animation {
    func repeatAnimation(while expression: Bool, autoreverses: Bool = true) -> Animation {
        expression ? repeatForever(autoreverses: autoreverses) : self
    }
}
