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
            Spacer()
        }
        .padding()
    }
    var questionCard: some View {
        Text(questions[0].text)
            .font(.system(size: 24, weight: .medium))
            .foregroundColor(.white)
            .frame(maxWidth: .infinity, maxHeight: 300)
            .background(Color.green)
            .cornerRadius(16)
    }
}

struct QuestionView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            QuestionView(questions: PersistenceController.loadPreviewRestaurant().questions)
        }
    }
}
