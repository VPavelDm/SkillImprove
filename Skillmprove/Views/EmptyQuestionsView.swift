//
//  EmptyQuestionsView.swift
//  Skillmprove
//
//  Created by Pavel Vaitsikhouski on 20.12.21.
//

import SwiftUI

struct EmptyQuestionsView: View {
    var body: some View {
        VStack {
            Image("empty")
                .resizable()
                .aspectRatio(1.0, contentMode: .fit)
                .padding()
            Text("There aren't any cards")
                .font(.custom("MarkerFelt-Wide", size: 24))
            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .transition(.scale)
    }
}

struct EmptyQuestionsView_Previews: PreviewProvider {
    static var previews: some View {
        EmptyQuestionsView()
    }
}
