//
//  QuizGameView.swift
//  Skillmprove
//
//  Created by Pavel Vaitsikhouski on 15.12.21.
//

import SwiftUI

struct QuizGameView: View {
    @State private var shouldShowFilters = false
    @State var search: QuizGameSearch
    @StateObject private var game = QuizGame()
    
    var body: some View {
        NavigationView {
            QuestionsView(questions: $game.questions)
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
}

struct QuizGameView_Previews: PreviewProvider {
    static var previews: some View {
        QuizGameView(search: QuizGameSearch())
    }
}
