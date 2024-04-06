import Foundation

struct TodayProgress {
    var learnedTodayMinutes: Int
    var targetLearningMinutes: Int
    var progress: CGFloat { CGFloat(learnedTodayMinutes) / CGFloat(targetLearningMinutes) }
}
