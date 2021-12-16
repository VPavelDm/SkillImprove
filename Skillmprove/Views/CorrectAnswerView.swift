//
//  CorrectAnswerView.swift
//  Skillmprove
//
//  Created by Pavel Vaitsikhouski on 15.12.21.
//

import SwiftUI
import ConfettiSwiftUI

struct CorrectAnswerView: View {
    @State private var confettiCounter = 0
    @Binding var isPresented: Bool
    
    var body: some View {
        ZStack {
            Color.black.opacity(0.5)
            card
        }
        .edgesIgnoringSafeArea(.all)
    }
    
    var card: some View {
        ZStack(alignment: .bottom) {
            VStack {
                Spacer()
                cup
                title
                description
                Spacer()
                nextButton
            }
            ConfettiCannon(counter: $confettiCounter,
                           num: 50,
                           colors: [.purple, .cyan],
                           confettiSize: 20,
                           radius: 400)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .aspectRatio(1.0, contentMode: .fit)
        .background(Color.white)
        .cornerRadius(16)
        .padding(24)
        .shadow(radius: 5)
        .onAppear {
            confettiCounter += 1
        }
    }
    var cup: some View {
        Text("🏆")
            .font(.system(size: 90))
    }
    var title: some View {
        Text("Congrats!")
            .font(.custom("MarkerFelt-Wide", size: 32))
    }
    var description: some View {
        Text("Your answer is correct")
            .font(.subheadline)
            .foregroundColor(.secondary)
    }
    var nextButton: some View {
        Button {
            isPresented = false
        } label: {
            Text("Next")
                .font(.system(size: 18, weight: .semibold))
                .foregroundColor(.white)
                .padding(.vertical, 10)
                .padding(.horizontal, 64)
                .background(
                    LinearGradient(colors: [.purple, .cyan], startPoint: .topLeading, endPoint: .bottomTrailing)
                )
                .cornerRadius(16)
                .shadow(radius: 5)
        }
        .padding(.bottom, 16)
    }
}

struct CorrectAnswerView_Previews: PreviewProvider {
    static var previews: some View {
        CorrectAnswerView(isPresented: .constant(true))
    }
}
