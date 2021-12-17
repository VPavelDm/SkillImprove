//
//  QuestionView.swift
//  Skillmprove
//
//  Created by Pavel Vaitsikhouski on 15.12.21.
//

import SwiftUI

struct QuizGameView: View {
    @State var search: QuizGameSearch
    
    var body: some View {
        QuizGameStorageView(search)
            .background(
                LinearGradient(colors: [.purple, .cyan], startPoint: .top, endPoint: .bottom)
            )
            .navigationBarTitleDisplayMode(.inline)
    }
}

struct QuizGameStorageView: View {
    
    // MARK: - Properties
    @FetchRequest
    private var questions: FetchedResults<Question>
    
    // MARK: - Inits
    init(_ search: QuizGameSearch) {
        let request = Question.fetchRequest(search.predicate)
        self._questions = FetchRequest(fetchRequest: request)
    }

    // MARK: - Views
    var body: some View {
        content
    }
    var content: some View {
        QuestionsView(questions.shuffled())
    }
}

struct QuestionsView: View {
    @State private var questions: [Question]
    
    init(_ questions: [Question]) {
        self._questions = State(initialValue: questions)
    }
    
    var body: some View {
        VStack {
            DeckView(cards: questions) {
                questions.removeLast()
            } content: { question in
                Text(question.text)
                    .foregroundColor(.black)
                    .cardify()
            }
            .padding()
            Spacer()
        }
    }
}

struct QuizGameView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            QuizGameView(search: QuizGameSearch())
        }
    }
}
