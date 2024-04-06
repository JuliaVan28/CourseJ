import SwiftUI

struct TodayProgressCard: View {
    @Binding var progress: TodayProgress

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text("mycourses.learned")
                .font(.poppinsFootnote)
                .foregroundColor(.secondaryColor)
            HStack(alignment: .firstTextBaseline, spacing: 4) {
                Text("mycourses.min \(progress.learnedTodayMinutes)")
                    .font(.poppinsTitle2)
                    .fontWeight(.semibold)
                Group {
                    Text("/")
                        .accessibilityLabel(Text("mycourses.accessibility.of"))
                    Text("mycourses.min \(progress.targetLearningMinutes)")
                }
                .font(.poppinsCaption2)
                .foregroundColor(.secondaryColor)
            }
            ProgressBar(value: progress.progress)
        }
        .cardStyle()
        .accessibilityElement(children: .combine)
        .accessibilityAddTraits(.isHeader)
        .accessibilityIdentifier(viewName)
    }
}

struct TodayProgressCard_Previews: PreviewProvider {
    static var previews: some View {
        TodayProgressCard(progress: .constant(TodayProgress(learnedTodayMinutes: 20, targetLearningMinutes: 60)))
            .previewLayout(.sizeThatFits)
    }
}
