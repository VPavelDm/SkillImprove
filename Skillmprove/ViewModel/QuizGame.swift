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
    var search: QuizGameSearch
    
    // MARK: - Inits
    init(context: NSManagedObjectContext) {
        repository = QuestionsManager(context: context)
        
        let filters = (try? repository.loadFilters()) ?? []
        search = QuizGameSearch(filters)
        
        loadQuestions()
    }
        
    // MARK: - Intents
    func loadQuestions() {
        do {
            questions = try repository.loadQuestions(search: search)
        } catch {
            print(error.localizedDescription)
        }
    }
    func removeQuestion() {
        let question = questions.removeLast()
        do {
            try repository.markQuestionAsShown(question: question)
        } catch {
            print(error.localizedDescription)
        }
    }
}
