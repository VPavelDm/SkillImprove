//
//  DeckView.swift
//  Skillmprove
//
//  Created by Pavel Vaitsikhouski on 15.12.21.
//

import SwiftUI

struct DeckView<Card, Item>: View where Card: View {
    @State private var topCardOffset: CGSize = .zero
    var cards: [Item]
    var onRemove: () -> Void
    var content: (Item) -> Card
    
    // MARK: - Views
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                ForEach(cards.indices, id: \.self) { index in
                    content(cards[index])
                        .zIndex(Double(index))
                        .opacity(isCardVisible(at: index) ? 1 : 0)
                        .offset(x: dragOffset(at: index).width, y: dragOffset(at: index).height)
                        .offset(x: 0, y: offset(at: index))
                        .scaleEffect(scale(at: index))
                        .rotationEffect(dragRotation(at: index))
                        .gesture(
                            DragGesture()
                                .onChanged { value in
                                    topCardOffset = value.translation
                                }
                                .onEnded { value in
                                    withAnimation {
                                        if abs(gesturePercentage(geometry, from: value)) > thresholdPercentage {
                                            onRemove()
                                        }
                                        topCardOffset = .zero
                                    }
                                }
                        )
                        .transition(.asymmetric(insertion: .identity, removal: .move(edge: .leading)))
                }
            }
        }
    }
    
    // MARK: - Utils
    private func gesturePercentage(_ geometry: GeometryProxy, from gesture: DragGesture.Value) -> CGFloat {
        gesture.translation.width / geometry.size.width
    }
    
    // MARK: - UI Utils
    private func dragRotation(at index: Int) -> Angle {
        guard index == cards.count - 1 else { return .zero }
        return .degrees(topCardOffset.width / 20)
    }
    private func dragOffset(at index: Int) -> CGSize {
        guard index == cards.count - 1 else { return .zero }
        return topCardOffset
    }
    private func offset(at index: Int) -> Double {
        if isCardVisible(at: index) {
            return Double((cards.count - 1 - index) * -13)
        } else {
            return offset(at: index + 1)
        }
    }
    private func scale(at index: Int) -> Double {
        1 - Double(cards.count - 1 - index) * 0.02
    }
    func isCardVisible(at index: Int) -> Bool {
        cards.count <= visibleCardsCount || index >= cards.count - visibleCardsCount
    }
    
    // MARK: - Constants
    private let visibleCardsCount = 3
    private let thresholdPercentage: Double = 0.5
}

struct DeckView_Previews: PreviewProvider {
    private struct ContentView: View {
        @State var cards = (1...10).map { "\($0)" }
        
        var body: some View {
            ZStack {
                Color.red.ignoresSafeArea()
                DeckView(cards: cards) {
                    cards.removeLast()
                } content: { card in
                    Text(card)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .aspectRatio(1.0, contentMode: .fit)
                        .background(Color.white)
                        .cornerRadius(16)
                        .shadow(radius: 5)
                }
                .padding()
            }
        }
    }
    static var previews: some View {
        ContentView()
    }
}
