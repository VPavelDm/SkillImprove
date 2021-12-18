//
//  QuestionsManager.swift
//  Skillmprove
//
//  Created by Pavel Vaitsikhouski on 17.12.21.
//

import Foundation
import CoreData

class QuestionsManager {
    private var context: NSManagedObjectContext
    
    init(context: NSManagedObjectContext) {
        self.context = context
    }
    
    func loadQuestions(search: QuizGameSearch) throws -> [Question] {
        let fetchRequest = Question.fetchRequest(search.predicate)
        return try context.fetch(fetchRequest)
    }
}
