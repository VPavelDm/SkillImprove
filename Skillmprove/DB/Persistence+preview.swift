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
    static func loadPreviewRestaurant() -> Topic {
        let context = preview.container.viewContext
        let content: ContentTO = try! readJSON(path: "topics")
        return map(from: content.topics.first!, in: context)
    }
}

// MARK: - TOs
private struct ContentTO: Decodable {
    var topics: [TopicTO]
}
private struct TopicTO: Decodable {
    var title: String
    var card: CardTO
    var questions: [QuestionTO]
}
private struct CardTO: Decodable {
    var textColor: String
    var backgroundColors: [String]
}
private struct QuestionTO: Decodable {
    var text: String
    var answer: String
}

// MARK: - Mapping
extension PersistenceController {
    private static func map(from object: ContentTO, in context: NSManagedObjectContext) -> [Topic] {
        object.topics.map { map(from: $0, in: context) }
    }
    private static func map(from object: TopicTO, in context: NSManagedObjectContext) -> Topic {
        let topic = Topic(context: context)
        topic.title = object.title
        topic.card = map(from: object.card, in: context)
        topic.questions = object.questions.map { map(from: $0, in: context) }
        return topic
    }
    private static func map(from object: CardTO, in context: NSManagedObjectContext) -> Card {
        let card = Card(context: context)
        card.textColor = Color(hex: object.textColor)
        card.backgroundColors = object.backgroundColors.map { Color(hex: $0) }
        return card
    }
    private static func map(from object: QuestionTO, in context: NSManagedObjectContext) -> Question {
        let question = Question(context: context)
        question.text = object.text
        question.answer = object.answer
        return question
    }
}
