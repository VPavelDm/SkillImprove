//
//  DeckView.swift
//  Skillmprove
//
//  Created by Pavel Vaitsikhouski on 15.12.21.
//

import SwiftUI

struct DeckView<Card, EmptyView, Item>: View where Card: View, EmptyView: View {
    var cards: [Item]
    @ViewBuilder var content: (Int) -> Card
    @ViewBuilder var empty: () -> EmptyView
    
    // MARK: - Views
    var body: some View {
        ZStack {
            if cards.isEmpty {
                empty()
            } else {
                ForEach(cards.indices, id: \.self) { index in
                    content(index)
                        .zIndex(Double(index))
                        .opacity(isCardVisible(at: index) ? 1 : 0)
                        .offset(x: 0, y: offset(at: index))
                        .scaleEffect(scale(at: index))
                }
            }
        }
    }
    
    // MARK: - UI Utils
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
}

struct DeckView_Previews: PreviewProvider {
    private struct ContentView: View {
        @State var cards = (1...10).map { "\($0)" }
        
        var body: some View {
            ZStack {
                Color.red.ignoresSafeArea()
                DeckView(cards: cards) { index in
                    Text(cards[index])
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .aspectRatio(1.0, contentMode: .fit)
                        .background(Color.white)
                        .cornerRadius(16)
                        .shadow(radius: 5)
                } empty: {
                    Text("Empty")
                }
                .padding()
            }
        }
    }
    static var previews: some View {
        ContentView()
    }
}
