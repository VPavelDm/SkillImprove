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
    
    // MARK: - Inits
    init(questions: [Question]) {
        self._questions = State(initialValue: questions)
    }

    // MARK: - Views
    var body: some View {
        content
            .navigationBarTitleDisplayMode(.inline)
    }
    var content: some View {
        VStack {
            questionCard
                .padding()
            Spacer()
            answers
        }
        .background(
            LinearGradient(colors: [.purple, .cyan], startPoint: .top, endPoint: .bottom)
        )
    }
    var questionCard: some View {
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
    var answers: some View {
        LazyVGrid(columns: [.init(spacing: 2), .init()], spacing: 2) {
            ForEach(1...4, id: \.self) { _ in
                answerButton
            }
        }
    }
    var answerButton: some View {
        Button {
            
        } label: {
            Text("Answer")
                .fontWeight(.medium)
                .frame(maxWidth: .infinity)
                .foregroundColor(.white)
                .padding(.vertical, 20)
                .background(Color.purple.opacity(0.5))
        }

    }
    
    // MARK: - UI Utils
    func questionCardOffset(for index: Int) -> Double {
        Double((questions.count - 1 - index) * 5)
    }
    
}

struct QuestionView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            QuestionView(questions: PersistenceController.loadPreviewRestaurant().questions)
        }
    }
}
