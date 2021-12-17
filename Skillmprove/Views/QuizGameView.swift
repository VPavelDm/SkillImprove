//
//  QuizGameView.swift
//  Skillmprove
//
//  Created by Pavel Vaitsikhouski on 15.12.21.
//

import SwiftUI

struct QuizGameView: View {
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
        QuestionsView(questions.shuffled())
            .background(
                LinearGradient(colors: [.purple, .cyan], startPoint: .top, endPoint: .bottom)
            )
            .navigationBarTitleDisplayMode(.inline)
    }
}

struct QuizGameView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            QuizGameView(QuizGameSearch())
        }
    }
}
