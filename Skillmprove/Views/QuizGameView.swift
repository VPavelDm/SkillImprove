//
//  QuizGameView.swift
//  Skillmprove
//
//  Created by Pavel Vaitsikhouski on 15.12.21.
//

import SwiftUI
import CoreData

struct QuizGameView: View {
    @State private var shouldShowFilters = false
    @StateObject private var game: QuizGame
    @State private var initialCardsCount = 0
    
    init(context: NSManagedObjectContext) {
        _game = StateObject(wrappedValue: QuizGame(context: context))
    }
    
    var body: some View {
        NavigationView {
            content
                .padding(.top)
                .background(
                    LinearGradient(colors: [.purple, .cyan], startPoint: .top, endPoint: .bottom)
                )
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button {
                            shouldShowFilters = true
                        } label: {
                            Image(systemName: "line.3.horizontal.decrease.circle")
                                .foregroundColor(.white)
                        }
                    }
                }
                .sheet(isPresented: $shouldShowFilters) {
                    QuizGameFiltersView(search: $game.search) {
                        game.loadQuestions()
                    }
                }
        }
        .onAppear {
            initialCardsCount = game.questions.count
        }
        .onChange(of: shouldShowFilters, perform: { _ in
            initialCardsCount = game.questions.count
        })
    }
    private var content: some View {
        GeometryReader { geometry in
            VStack {
                deck(in: geometry.size)
                actionsPanel
                Spacer()
            }
        }
    }
    private func deck(in size: CGSize) -> some View {
        DeckView(cards: game.questions) { index in
            let question = game.questions[index]
            card(with: question.text, index: index)
                .cardify {
                    card(with: question.answer, index: index)
                }
                .dragToRemove(in: size) {
                    game.removeQuestion()
                }
                .disabled(game.questions.last != question)
        } empty: {
            EmptyQuestionsView()
        }
        .padding()
    }
    private func card(with text: String, index: Int) -> some View {
        VStack {
            Text("\(initialCardsCount - index) of \(initialCardsCount)")
                .font(.system(size: 14, weight: .regular))
                .foregroundColor(.gray)
                .padding(.top)
            Spacer(minLength: 0)
            Text(text)
                .foregroundColor(.black)
                .padding()
            ForEach(0..<3, id: \.self) { _ in
                Spacer(minLength: 0)
            }
        }
    }
    @ViewBuilder
    private var actionsPanel: some View {
        if !game.questions.isEmpty {
            HStack(spacing: 20) {
                likeButton
            }
            .transition(.scale)
        }
    }
    private var likeButton: some View {
        Button {
            withAnimation {
                game.toggleLikeStatusOfQuestion()
            }
        } label: {
            ZStack {
                if game.questions.last?.isLiked ?? false {
                    Group {
                        Circle().foregroundColor(Color(hex: "34c759"))
                        heartIcon
                    }
                    .transition(.scale)
                } else {
                    Group {
                        Circle().foregroundColor(.red)
                        heartIcon
                    }
                    .transition(.scale)
                }
            }
            .frame(width: 44, height: 44)
        }
    }
    private var heartIcon: some View {
        Image(systemName: "suit.heart.fill")
            .resizable()
            .frame(width: 22, height: 20)
            .padding(.top, 2)
    }
}

struct QuizGameView_Previews: PreviewProvider {
    static var previews: some View {
        QuizGameView(context: PersistenceController.preview.mainContext)
    }
}
