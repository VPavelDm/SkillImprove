//
//  Cardify.swift
//  Skillmprove
//
//  Created by Pavel Vaitsikhouski on 15.12.21.
//

import SwiftUI

struct Cardify<ReverseContent>: ViewModifier where ReverseContent: View {
    @State private var isFaceUp = true
    var reverseContent: () -> ReverseContent
    
    // MARK: - Inits
    init(reverseContent: @escaping () -> ReverseContent) {
        self.reverseContent = reverseContent
    }

    // MARK: - Views
    func body(content: Content) -> some View {
        card(content: content)
            .rotatable(isFaceUp: isFaceUp) {
                card(content: reverseContent())
            }
            .aspectRatio(3/4, contentMode: .fit)
            .onTapGesture {
                withAnimation(.linear(duration: 0.5)) {
                    isFaceUp.toggle()
                }
            }
    }
    func card(content: Content) -> some View {
        ZStack {
            cardBackground
            content
        }
    }
    func card(content: ReverseContent) -> some View {
        ZStack {
            cardBackground
            content
        }
    }
    var cardBackground: some View {
        RoundedRectangle(cornerRadius: 16)
            .fill()
            .foregroundColor(.white)
            .shadow(radius: 5)
    }}

extension View {
    func cardify<ReverseContent>(
        reverseContent: @escaping () -> ReverseContent
    ) -> some View where ReverseContent: View {
        modifier(Cardify(reverseContent: reverseContent))
    }
}
