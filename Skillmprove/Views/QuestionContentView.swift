//
//  QuestionContentView.swift
//  Skillmprove
//
//  Created by Pavel Vaitsikhouski on 16.12.21.
//

import SwiftUI

struct QuestionContentView: View {
    var text: String
    
    var body: some View {
        Text(text)
            .foregroundColor(.black)
            .font(.title)
            .padding()
    }
}

struct QuestionContentView_Previews: PreviewProvider {
    static var previews: some View {
        QuestionContentView(text: "Very long text. ====================================")
            .cardify {
            }
            .padding()
            .background(
                LinearGradient(colors: [.purple, .cyan],
                               startPoint: .topTrailing, endPoint: .bottomTrailing)
            )
    }
}
