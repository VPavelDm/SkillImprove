//
//  Cardify.swift
//  Skillmprove
//
//  Created by Pavel Vaitsikhouski on 15.12.21.
//

import SwiftUI

struct Cardify: ViewModifier {
    @State private var offset: CGSize = CGSize.zero

    func body(content: Content) -> some View {
        ZStack {
            RoundedRectangle(cornerRadius: 16)
                .foregroundColor(.white)
            content
        }
        .aspectRatio(1.0, contentMode: .fit)
        .rotationEffect(.degrees(Double(offset.width / 20)), anchor: .bottom)
        .offset(x: offset.width, y: 0)
        .gesture(
            DragGesture()
                .onChanged { gesture in
                    offset = gesture.translation
                }
                .onEnded { _ in
                    withAnimation {
                        offset = .zero
                    }
                }
        )
    }
}

extension View {
    func cardify() -> some View {
        modifier(Cardify())
    }
}
