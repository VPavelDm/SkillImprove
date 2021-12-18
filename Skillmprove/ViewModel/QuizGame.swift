//
//  QuizGame.swift
//  Skillmprove
//
//  Created by Pavel Vaitsikhouski on 17.12.21.
//

import SwiftUI
import CoreData

class QuizGame: ObservableObject {
    private let repository: QuestionsManager
    @Published private(set) var questions: [Question] = []
    
    init(context: NSManagedObjectContext) {
        repository = QuestionsManager(context: context)
    }
        
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
