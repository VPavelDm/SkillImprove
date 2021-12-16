//
//  CorrectAnswerView.swift
//  Skillmprove
//
//  Created by Pavel Vaitsikhouski on 15.12.21.
//

import SwiftUI

struct CorrectAnswerView: View {
    
    var body: some View {
        ZStack {
            Color.black.opacity(0.5)
            Text("Congrats!")
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .aspectRatio(1.0, contentMode: .fit)
                .background(Color.white)
                .cornerRadius(16)
                .padding(24)
                .shadow(radius: 5)
        }
        .edgesIgnoringSafeArea(.all)
    }
}

struct CorrectAnswerView_Previews: PreviewProvider {
    static var previews: some View {
        CorrectAnswerView()
    }
}
