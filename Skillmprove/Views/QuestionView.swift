//
//  QuestionView.swift
//  Skillmprove
//
//  Created by Pavel Vaitsikhouski on 15.12.21.
//

import SwiftUI

struct QuestionView: View {
    var questions: [Question]
    
    var body: some View {
        content
            .navigationBarTitleDisplayMode(.inline)
            .navigationTitle("Question")
            .disableNavigationBarTransparancy()
    }
    var content: some View {
        VStack {
            questionCard
                .padding()
            Spacer()
            answers
        }
    }
    var questionCard: some View {
        Text(questions[0].text)
            .font(.system(size: 24, weight: .medium))
            .foregroundColor(.white)
            .frame(maxWidth: .infinity, maxHeight: 300)
            .background(Color.green)
            .cornerRadius(16)
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
            Text("answer")
                .frame(maxWidth: .infinity)
                .padding(.vertical, 10)
                .background(Color.red)
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
