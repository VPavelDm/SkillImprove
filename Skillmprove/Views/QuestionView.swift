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
        Text(questions[0].text)
    }
}
