//
//  QuizGameView.swift
//  Skillmprove
//
//  Created by Pavel Vaitsikhouski on 15.12.21.
//

import SwiftUI

struct QuizGameView: View {
    @State private var shouldShowFilters = false
    @State var search: QuizGameSearch
    @FetchRequest private var questions: FetchedResults<Question>
    
    // MARK: - Inits
    init(_ search: QuizGameSearch) {
        self._search = State(initialValue: search)
        let request = Question.fetchRequest(search.predicate)
        self._questions = FetchRequest(fetchRequest: request)
    }
    
    // MARK: - Views
    var body: some View {
        NavigationView {
            QuestionsView(questions.shuffled())
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
                .onChange(of: search) { newSearch in
                    questions.nsPredicate = newSearch.predicate
                }
                .sheet(isPresented: $shouldShowFilters) {
                    QuizGameFiltersView(search: $search)
                }
        }
    }
}

struct QuizGameView_Previews: PreviewProvider {
    static var previews: some View {
        QuizGameView(QuizGameSearch())
    }
}
