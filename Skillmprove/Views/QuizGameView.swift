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
    @State var search: QuizGameSearch
    @StateObject private var game: QuizGame
    
    init(context: NSManagedObjectContext, search: QuizGameSearch) {
        _game = StateObject(wrappedValue: QuizGame(context: context))
        _search = State(initialValue: search)
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
                    QuizGameFiltersView(search: $search)
                }
                .onChange(of: search) { newSearch in
                    game.loadQuestions(search: newSearch)
                }
                .onAppear {
                    game.loadQuestions(search: search)
                }
        }
    }
    private var content: some View {
        VStack {
            DeckView(cards: game.questions) {
                game.removeQuestion()
            } content: { question in
                VStack {
                    if let photoName = question.photoName {
                        Image(photoName)
                            .resizable()
                            .aspectRatio(1.0, contentMode: .fit)
                    }
                    Text(question.text)
                        .foregroundColor(.black)
                    Spacer()
                }
                .cardify()
            }
            .padding()
            Spacer()
        }
    }
}

struct QuizGameView_Previews: PreviewProvider {
    static var previews: some View {
        QuizGameView(context: PersistenceController.preview.mainContext,
                     search: QuizGameSearch())
    }
}
