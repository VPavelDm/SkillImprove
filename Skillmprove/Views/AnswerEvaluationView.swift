//
//  AnswerEvaluationView.swift
//  Skillmprove
//
//  Created by Pavel Vaitsikhouski on 15.12.21.
//

import SwiftUI
import ConfettiSwiftUI

enum AnswerEvaluationType {
    case correct
    case wrong
}

struct AnswerEvaluationView: View {
    @State private var confettiCounter = 0
    @State private var shouldStartIconRotationAnimation = false
    @Binding var isPresented: Bool
    var answerType: AnswerEvaluationType
    
    // MARK: - Views
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
            if answerType == .correct {
                ConfettiCannon(counter: $confettiCounter,
                               num: 50,
                               colors: [.purple, .cyan],
                               confettiSize: 20,
                               radius: 400)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .aspectRatio(1.0, contentMode: .fit)
        .background(Color.white)
        .cornerRadius(16)
        .padding(24)
        .shadow(radius: 5)
        .onAppear {
            confettiCounter += 1
            if answerType == .wrong {
                shouldStartIconRotationAnimation = true
            }
        }
    }
    var cup: some View {
        Text(answerType == .correct ? correctIcon : wrongIcon)
            .font(.system(size: 90))
            .rotationEffect(.init(degrees: shouldStartIconRotationAnimation ? 360 : 0))
            .animation(.linear(duration: 1), value: shouldStartIconRotationAnimation)
    }
    var title: some View {
        Text(answerType == .correct ? correctTitle : wrongTitle)
            .font(.custom("MarkerFelt-Wide", size: 32))
    }
    var description: some View {
        Text(answerType == .correct ? correctDescription : wrongDescription)
            .font(.subheadline)
            .foregroundColor(.secondary)
    }
    var nextButton: some View {
        Button {
            isPresented = false
        } label: {
            Text(answerType == .correct ? nextBtnCorrect : nextBtnWrong)
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
    
    // MARK: - Constants
    private let nextBtnCorrect = "Next"
    private let nextBtnWrong = "Try again"
    private let correctDescription = "Your answer is correct"
    private let wrongDescription = "Your answer is wrong"
    private let correctTitle = "Congrats!"
    private let wrongTitle = "Sorry! 😔"
    private let correctIcon = "🏆"
    private let wrongIcon = "🚫"
}

struct CorrectAnswerView_Previews: PreviewProvider {
    static var previews: some View {
        AnswerEvaluationView(isPresented: .constant(true), answerType: .correct)
    }
}
