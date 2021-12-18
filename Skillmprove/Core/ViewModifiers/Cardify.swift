//
//  Cardify.swift
//  Skillmprove
//
//  Created by Pavel Vaitsikhouski on 15.12.21.
//

import SwiftUI

struct Cardify<ReverseContent>: ViewModifier where ReverseContent: View {
    @State private var dragCardOffset: CGSize = .zero
    @State private var isFaceUp = true
    var onRemove: () -> Void
    var reverseContent: () -> ReverseContent
    
    // MARK: - Inits
    init(onRemove: @escaping () -> Void, reverseContent: @escaping () -> ReverseContent) {
        self.onRemove = onRemove
        self.reverseContent = reverseContent
    }

    // MARK: - Views
    func body(content: Content) -> some View {
        GeometryReader { geometry in
            card(content: content)
                .rotationEffect(.degrees(dragCardOffset.width / 20), anchor: .bottom)
                .offset(x: dragCardOffset.width, y: dragCardOffset.height)
                .gesture(dragGesture(in: geometry.size))
        }
        .transition(removeTransition)
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
            RoundedRectangle(cornerRadius: 16)
                .fill()
                .foregroundColor(.white)
                .shadow(radius: 5)
            content
        }
    }
    func card(content: ReverseContent) -> some View {
        ZStack {
            RoundedRectangle(cornerRadius: 16)
                .fill()
                .foregroundColor(.white)
                .shadow(radius: 5)
            content
        }
    }
    
    // MARK: - Gestures
    func dragGesture(in size: CGSize) -> some Gesture {
        DragGesture()
            .onChanged({ value in
                dragCardOffset = value.translation
            })
            .onEnded({ value in
                withAnimation {
                    if abs(getGesturePercentage(in: size, from: value)) > thresholdPercentage {
                        onRemove()
                    } else {
                        dragCardOffset = .zero
                    }
                }
            })
    }
    
    // MARK: - Utils
    private func getGesturePercentage(in size: CGSize, from gesture: DragGesture.Value) -> CGFloat {
        gesture.translation.width / size.width
    }
    
    // MARK: - Constants
    private var removeTransition: AnyTransition {
        .move(edge: .bottom)
        .combined(with: .move(edge: dragCardOffset.width < 0 ? .leading : .trailing))
    }
    private var thresholdPercentage: CGFloat = 0.5
}

extension View {
    func cardify<ReverseContent>(
        reverseContent: @escaping () -> ReverseContent,
        onRemove: @escaping () -> Void
    ) -> some View where ReverseContent: View {
        modifier(Cardify(onRemove: onRemove, reverseContent: reverseContent))
    }
}
