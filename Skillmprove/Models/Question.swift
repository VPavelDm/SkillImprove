//
//  Question.swift
//  Skillmprove
//
//  Created by Pavel Vaitsikhouski on 15.12.21.
//

import Foundation
import CoreData

extension Question {
    var text: String {
        get { text_! }
        set { text_ = newValue }
    }
    var category: String {
        get { category_! }
        set { category_ = newValue }
    }
    var answer: String {
        get { answer_! }
        set { answer_ = newValue }
    }
    
    // MARK: - Requests
    static func fetchRequest(_ predicate: NSPredicate) -> NSFetchRequest<Question> {
        let request = NSFetchRequest<Question>(entityName: "Question")
        request.sortDescriptors = [NSSortDescriptor(keyPath: \Question.text_, ascending: true)]
        request.predicate = predicate
        return request
    }
}
