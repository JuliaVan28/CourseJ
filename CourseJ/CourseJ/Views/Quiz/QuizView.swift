import SwiftUI
import Foundation
import Swift


struct QuizView: View {
    @Binding var isPresented: Bool
    let course: Course

    init(isPresented: Binding<Bool>, course: Course) {
        _isPresented = isPresented
        self.course = course
        _quiz = StateObject(wrappedValue: QuizController(course: course))
    }

    @StateObject private var quiz: QuizController
    @State private var isContentListPresented = false
    @Environment(\.presentationMode) private var presentationMode
   /* private var presentationBindings: [Binding<Bool>] {
        [$quiz.areStatsPresented, $isPresented]
       // presentations + [$quiz.areStatsPresented, $isPresented]
    }*/
    
    private var presentationBinding: Binding<Bool> {
            Binding<Bool>(
                get: { $quiz.areStatsPresented.wrappedValue || isPresented },
                set: { newValue in
                    $quiz.areStatsPresented.wrappedValue = newValue
                    isPresented = newValue
                }
            )
        }

    var body: some View {
        NavigationStack {
            VStack {
                ProgressWithContentList(isContentListPresented: $isContentListPresented)
                ModulesView()
            }
            .navigationTitle(quiz.course.wrappedTitle)
            .navigationBarTitleDisplayMode(.inline)
            .ignoresSafeArea(edges: .bottom)
            .backgroundColorStyle()
            .sheet(isPresented: $isContentListPresented) { ContentList() }
            .fullScreenCover(isPresented: $quiz.areStatsPresented) { QuizStatsView() }
            .toolbar { ToolbarItem(placement: .navigation) { ToolBarDismissButton() } }
        }
        /*.environment(\.presentationMode, Binding(
            get: { self.presentationMode.wrappedValue },
            set: { self.presentationMode.wrappedValue = $0 }
        )as! KeyPath<EnvironmentValues, Binding<PresentationMode>>)*/
        //.environment(\.presentations, presentationBindings)
        .environmentObject(quiz)
        .onChange(of: quiz.isPresented) { isPresented = $0 }
        .accessibilityIdentifier(viewName)
    }
}

// MARK: - Helper views

private struct ProgressWithContentList: View {
    @EnvironmentObject private var quiz: QuizController
    @Binding var isContentListPresented: Bool

    var body: some View {
        Button {
            isContentListPresented = true
        } label: {
            ProgressBar(
                value: quiz.course.progressValue,
                total: quiz.course.progressTotal,
                indicatorColor: CategoryEnum.color(for: quiz.course.wrappedCategory.category)
            )
            .frame(height: 35)
            .animation(.spring(), value: quiz.course.progressValue)
            .padding(.horizontal, .Padding)
        }
        .accessibilityIdentifier(viewName)
    }
}

private struct ModulesView: View {
    @EnvironmentObject private var quiz: QuizController
    private var modules: [CourseModule] { quiz.course.modulesArray }

    var body: some View {
        TabView(selection: $quiz.course.currentModule) {
            ForEach(Array(modules.enumerated()), id: \.offset) { _, moduleItem in
                ModuleByType(moduleItem: moduleItem) { quiz.calculateModuleProgression() }
            }
        }
        .tabViewStyle(.page(indexDisplayMode: .never))
        .accessibilityIdentifier(viewName)
    }
}

private struct ToolBarDismissButton: View {
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        Button {
            dismiss()
        } label: {
            Image(systemName: "xmark")
                .font(.system(size: 16, weight: .bold))
                .padding(10)
                .tint(.secondary)
        }
        .accessibilityIdentifier(viewName)
    }
}

struct QuizView_Previews: PreviewProvider {
    static var previews: some View {
        QuizView(isPresented: .constant(true), course: MockData.courseOne)
            .preferredColorScheme(.dark)
            .environmentObject(QuizController(course: MockData.courseOne))
    }
}
