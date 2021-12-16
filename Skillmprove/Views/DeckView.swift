//
//  DeckView.swift
//  Skillmprove
//
//  Created by Pavel Vaitsikhouski on 15.12.21.
//

import SwiftUI

struct DeckView: View {
    @Binding var questions: [Question]
    
    // MARK: - Views
    var body: some View {
        ZStack {
            ForEach(questions.indices, id: \.self) { index in
                QuestionContentView(text: questions[index].text)
                    .cardify {
                        questions.remove(at: index)
                    }
                    .offset(x: questionCardOffset(for: index),
                            y: -questionCardOffset(for: index))
                    .opacity(isQuestionCardVisible(for: index) ? 1 : 0)
                    .zIndex(Double(index))
            }
        }
    }
    
    // MARK: - UI Utils
    func questionCardOffset(for index: Int) -> Double {
        if isQuestionCardVisible(for: index) {
            return Double((questions.count - 1 - index) * cardOffsetFactor)
        } else {
            return questionCardOffset(for: questions.count - visibleCardsCount)
        }
    }
    func isQuestionCardVisible(for index: Int) -> Bool {
        questions.count <= visibleCardsCount || index >= questions.count - visibleCardsCount
    }
    
    // MARK: - UI Constants
    private let visibleCardsCount = 3
    private let cardOffsetFactor = 5
}

