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
                Text(questions[index].text)
                    .cardify {
                        questions.remove(at: index)
                    }
                    .offset(x: questionCardOffset(for: index),
                            y: -questionCardOffset(for: index))
                    .zIndex(Double(index))
            }
        }
    }
    
    // MARK: - UI Utils
    func questionCardOffset(for index: Int) -> Double {
        Double((questions.count - 1 - index) * 5)
    }
}

