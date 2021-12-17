//
//  QuestionView.swift
//  Skillmprove
//
//  Created by Pavel Vaitsikhouski on 15.12.21.
//

import SwiftUI

struct QuestionView: View {
    
    // MARK: - Properties
    @State private var questions: [Question]
    @State private var shouldShowAlert = false
    @State private var isAnswerCorrect: Bool?
    private var currentQuestion: Question? {
        questions.last
    }
    
    // MARK: - Inits
    init(questions: [Question]) {
        self._questions = State(initialValue: questions)
    }

    // MARK: - Views
    var body: some View {
        content
    }
    var content: some View {
        VStack {
            DeckView(cards: questions) {
                questions.removeLast()
            } content: { question in
                Text(question.text)
                    .cardify()
            }
            .padding()
            Spacer()
        }
        .background(
            LinearGradient(colors: [.purple, .cyan], startPoint: .top, endPoint: .bottom)
        )
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct QuestionView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            QuestionView(questions: PersistenceController.loadPreviewRestaurant())
        }
    }
}
