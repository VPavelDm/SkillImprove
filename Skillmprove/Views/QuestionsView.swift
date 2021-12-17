//
//  QuestionsView.swift
//  Skillmprove
//
//  Created by Pavel Vaitsikhouski on 17.12.21.
//

import SwiftUI

struct QuestionsView: View {
    @State private var questions: [Question]
    
    // MARK: - Inits
    init(_ questions: [Question]) {
        self._questions = State(initialValue: questions)
    }
    
    // MARK: - Views
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

