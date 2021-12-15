//
//  Cardify.swift
//  Skillmprove
//
//  Created by Pavel Vaitsikhouski on 15.12.21.
//

import SwiftUI

struct Cardify: ViewModifier {
    @State private var offset: CGSize = CGSize.zero
    private var offsetToRemove: Double { 50 }
    var onRemove: () -> Void

    func body(content: Content) -> some View {
        ZStack {
            RoundedRectangle(cornerRadius: 16)
                .fill()
                .foregroundColor(.white)
            content
        }
        .aspectRatio(1.0, contentMode: .fit)
        .shadow(radius: 5)
        .rotationEffect(.degrees(Double(offset.width / 20)), anchor: .bottom)
        .offset(x: offset.width, y: 0)
        .gesture(
            DragGesture()
                .onChanged { gesture in
                    offset = gesture.translation
                }
                .onEnded { _ in
                    withAnimation {
                        if abs(offset.width) > offsetToRemove {
                            onRemove()
                        } else {
                            offset = .zero
                        }
                    }
                }
        )
        .transition(
            .asymmetric(insertion: .identity,
                        removal: .move(edge: offset.width > 0 ? .trailing : .leading))
        )
    }
}

extension View {
    func cardify(onRemove: @escaping () -> Void) -> some View {
        modifier(Cardify(onRemove: onRemove))
    }
}
