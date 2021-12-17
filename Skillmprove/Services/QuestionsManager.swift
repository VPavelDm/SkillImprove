//
//  QuestionsManager.swift
//  Skillmprove
//
//  Created by Pavel Vaitsikhouski on 17.12.21.
//

import Foundation
import CoreData

class QuestionsManager {
    func loadQuestions(search: QuizGameSearch) throws -> [Question] {
        let fetchRequest = NSFetchRequest<Question>(entityName: "Question")
        fetchRequest.predicate = search.predicate
        let context = PersistenceController.preview.container.viewContext
        return try context.fetch(fetchRequest)
    }
}
