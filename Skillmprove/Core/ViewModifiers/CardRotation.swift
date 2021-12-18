//
//  CardRotation.swift
//  Skillmprove
//
//  Created by Pavel Vaitsikhouski on 18.12.21.
//

import SwiftUI

struct CardRotation<ReverseContent>: AnimatableModifier where ReverseContent: View {
    private var rotation: Double
    var animatableData: Double {
        get { rotation }
        set { rotation = newValue }
    }
    var isFaceUp: Bool {
        rotation < 90
    }
    var reverseContent: () -> ReverseContent

    // MARK: - Inits
    init(isFaceUp: Bool, @ViewBuilder reverseContent: @escaping () -> ReverseContent) {
        self.rotation = isFaceUp ? 0 : 180
        self.reverseContent = reverseContent
    }
    
    // MARK: - Views
    func body(content: Content) -> some View {
        Group {
            reverseContent()
                .opacity(isFaceUp ? 0 : 1)
                .rotation3DEffect(.degrees(180), axis: (0, 1, 0))
            content
                .opacity(isFaceUp ? 1 : 0)
        }
        .rotation3DEffect(Angle(degrees: rotation), axis: (0, 1, 0))
    }
}

extension View {
    
    func rotatable<ReverseContent>(
        isFaceUp: Bool,
        @ViewBuilder reverseContent: @escaping () -> ReverseContent
    ) -> some View where ReverseContent: View {
        modifier(CardRotation(isFaceUp: isFaceUp, reverseContent: reverseContent))
    }
}
