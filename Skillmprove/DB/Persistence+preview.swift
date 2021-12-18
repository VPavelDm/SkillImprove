//
//  Persistence+preview.swift
//  Skillmprove
//
//  Created by Pavel Vaitsikhouski on 15.12.21.
//

import Foundation
import CoreData
import SwiftUI

// MARK: - Preview
extension PersistenceController {
    static var preview: PersistenceController = {
        let result = PersistenceController(inMemory: true)
        let viewContext = result.container.viewContext
        
        do {
            let content: ContentTO = try readJSON(path: "topics")
            _ = map(from: content, in: viewContext)
            try viewContext.save()
        } catch {
            // Replace this implementation with code to handle the error appropriately.
            // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
        return result
    }()
    static func loadPreviewRestaurant() -> [Question] {
        let context = preview.container.viewContext
        let content: ContentTO = try! readJSON(path: "topics")
        return map(from: content, in: context)
    }
}

// MARK: - TOs
private struct ContentTO: Decodable {
    var questions: [QuestionTO]
}
private struct QuestionTO: Decodable {
    var text: String
    var correctAnswer: String
    var category: String
    var photoName: String?
}

// MARK: - Mapping
extension PersistenceController {
    private static func map(from object: ContentTO, in context: NSManagedObjectContext) -> [Question] {
        object.questions.map { map(from: $0, in: context) }
    }
    private static func map(from object: QuestionTO, in context: NSManagedObjectContext) -> Question {
        let question = Question(context: context)
        question.text = object.text
        question.correctAnswer = object.correctAnswer
        question.category = object.category
        question.photoName = object.photoName
        return question
    }
}
