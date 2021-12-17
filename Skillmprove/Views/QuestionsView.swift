//
//  QuestionsView.swift
//  Skillmprove
//
//  Created by Pavel Vaitsikhouski on 17.12.21.
//

import SwiftUI

struct QuestionsView: View {
    @Binding var questions: [Question]
    
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

