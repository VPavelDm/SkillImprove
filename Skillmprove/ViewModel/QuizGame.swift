//
//  QuizGame.swift
//  Skillmprove
//
//  Created by Pavel Vaitsikhouski on 17.12.21.
//

import SwiftUI

class QuizGame: ObservableObject {
    private let repository = QuestionsManager()
    @Published private(set) var questions: [Question] = []
        
    // MARK: - Intents
    func loadQuestions(search: QuizGameSearch) {
        do {
            questions = try repository.loadQuestions(search: search)
        } catch {
            print(error.localizedDescription)
        }
    }
    func removeQuestion() {
        questions.removeLast()
    }
}
