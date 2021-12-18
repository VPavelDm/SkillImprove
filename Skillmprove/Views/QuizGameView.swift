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
    }
    private var content: some View {
        VStack {
            DeckView(cards: game.questions) { question in
                VStack {
                    Spacer(minLength: 0)
                    Text(question.text)
                        .foregroundColor(.black)
                        .padding()
                    ForEach(0..<3, id: \.self) { _ in
                        Spacer(minLength: 0)
                    }
                }
                .cardify {
                    game.removeQuestion()
                }
            }
            .padding()
            Spacer()
        }
    }
}

struct QuizGameView_Previews: PreviewProvider {
    static var previews: some View {
        QuizGameView(context: PersistenceController.preview.mainContext)
    }
}
