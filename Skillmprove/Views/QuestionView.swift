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
        Text(questions[0].text)
            .font(.system(size: 24, weight: .medium))
            .frame(maxWidth: .infinity, maxHeight: 300)
            .background(Color.white)
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
            Text("Answer")
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
