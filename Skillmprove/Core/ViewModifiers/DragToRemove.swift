//
//  DragToRemove.swift
//  Skillmprove
//
//  Created by Pavel Vaitsikhouski on 23.12.21.
//

import SwiftUI

struct DragToRemove: ViewModifier {
    @State private var dragCardOffset: CGSize = .zero
    var size: CGSize
    var onRemove: () -> Void
    
    // MARK: - Inits
    init(size: CGSize, onRemove: @escaping () -> Void) {
        self.size = size
        self.onRemove = onRemove
    }

    // MARK: - Views
    func body(content: Content) -> some View {
        content
            .rotationEffect(.degrees(dragCardOffset.width / 20), anchor: .bottom)
            .offset(x: dragCardOffset.width, y: dragCardOffset.height)
            .gesture(dragGesture(in: size))
            .transition(removeTransition)
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
    func dragToRemove(in size: CGSize, onRemove: @escaping () -> Void) -> some View {
        modifier(DragToRemove(size: size, onRemove: onRemove))
    }
}
