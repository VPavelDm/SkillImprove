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
            .navigationBarTitleDisplayMode(.inline)
            .popup(isPresented: $shouldShowAlert) {
                if isAnswerCorrect == true {
                    CorrectAnswerView()
                } else {
                    CorrectAnswerView()
                }
            }
    }
    var content: some View {
        VStack {
            DeckView(questions: $questions)
                .padding()
            Spacer()
            answers
        }
        .background(
            LinearGradient(colors: [.purple, .cyan], startPoint: .top, endPoint: .bottom)
        )
    }
    var answers: some View {
        LazyVGrid(columns: [.init(spacing: 2), .init()], spacing: 2) {
            if let answers = currentQuestion?.answers {
                ForEach(answers) { answer in
                    answerButton(text: answer.text)
                }
            }
        }
    }
    func answerButton(text: String) -> some View {
        Button {
            isAnswerCorrect = currentQuestion?.correctAnswer == text
            shouldShowAlert = true
        } label: {
            Text(text)
                .fontWeight(.medium)
                .frame(maxWidth: .infinity)
                .foregroundColor(.white)
                .padding(.vertical, 20)
                .background(Color.purple.opacity(0.5))
        }
    }
        
}

struct QuestionView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            QuestionView(questions: PersistenceController.loadPreviewRestaurant().questions)
        }
    }
}
