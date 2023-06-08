import SwiftUI

extension Color {
    static let backgroundColor = Color("BackgroundColor")
    static let backgroundColor1 = Color("BackgroundColor1")
    static let backgroundColor2 = Color("BackgroundColor2")
    static let secondaryColor = Color("SecondaryColor")
    
    enum Button {
        static let inactiveButton = Color("InactiveButton")
    }

    enum Login {
        static let textColor = Color("LoginText")
    }
    
    enum Filter {
        static let buttonColor = Color("FilterButtonColor")
        static let buttonTextColor = Color("FilterButtonTextColor")
    }
    
    enum Progress {
        static let progressTrackColor = Color("ProgressTrack")
        static let progressOrangeColor = Color("ProgressOrange")
    }
    
    enum ChoiceQuiz {
        static let outerCircleButtonColor = Color("RadioButtonColor")
        static let innerCircleButtonColor = Color("RadioButtonInnerCircleColor")
        static let selectedRadioButtonColor = Color("RadioButtonSelectedColor")
        static let correctColor = Color("CorrectGreen")
        static let incorrectColor = Color("IncorrectRed")
    }

}
