//
//  QuizGameView.swift
//  Skillmprove
//
//  Created by Pavel Vaitsikhouski on 15.12.21.
//

import SwiftUI

struct ContentView: View {
    @State private var shouldShowFilters = false
    @State var search: QuizGameSearch
    
    var body: some View {
        NavigationView {
            QuizGameView(search)
                .background(
                    LinearGradient(colors: [.purple, .cyan], startPoint: .top, endPoint: .bottom)
                )
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button {
                            shouldShowFilters = true
                        } label: {
                            Image(systemName: "line.3.horizontal.decrease.circle")
                                .foregroundColor(.white)
                        }
                    }
                }
                .sheet(isPresented: $shouldShowFilters) {
                    QuizGameFiltersView(search: $search)
                }
        }
    }
}

struct QuizGameView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest private var questions: FetchedResults<Question>
    
    // MARK: - Inits
    init(_ search: QuizGameSearch) {
        let request = Question.fetchRequest(search.predicate)
        self._questions = FetchRequest(fetchRequest: request)
    }
    
    // MARK: - Views
    var body: some View {
//        VStack(spacing: 16) {
//            ForEach(questions) { question in
//                Text(question.text)
//            }
//        }
        QuestionsView(questions.shuffled())
    }
}

struct QuizGameView_Previews: PreviewProvider {
    static var previews: some View {
        QuizGameView(QuizGameSearch())
    }
}
