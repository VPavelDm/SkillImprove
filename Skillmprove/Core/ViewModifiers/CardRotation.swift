//
//  CardRotation.swift
//  Skillmprove
//
//  Created by Pavel Vaitsikhouski on 18.12.21.
//

import SwiftUI

struct CardRotation: AnimatableModifier {
    private var rotation: Double
    var animatableData: Double {
        get { rotation }
        set { rotation = newValue }
    }
    var isFaceUp: Bool {
        rotation < 90
    }

    init(isFaceUp: Bool) {
        rotation = isFaceUp ? 0 : 180
    }
    
    func body(content: Content) -> some View {
        content
            .rotation3DEffect(Angle(degrees: rotation), axis: (0, 1, 0))
    }
}

extension View {
    func cardRotation(isFaceUp: Bool) -> some View {
        modifier(CardRotation(isFaceUp: isFaceUp))
    }
}
