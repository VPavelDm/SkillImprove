//
//  TopicDBO.swift
//  Skillmprove
//
//  Created by Pavel Vaitsikhouski on 15.12.21.
//

import Foundation
import CoreData

extension Topic {
    var title: String {
        get { title_! }
        set { title_ = newValue }
    }
    var card: Card {
        get { card_! }
        set { card_ = newValue }
    }
    var questions: [Question] {
        get { questions_!.toArray() }
        set { questions_ = newValue.nsOrderedSet }
    }
    
    // MARK: - Requests
    static func fetchRequest(_ predicate: NSPredicate) -> NSFetchRequest<Topic> {
        let request = NSFetchRequest<Topic>(entityName: "Topic")
        request.sortDescriptors = [NSSortDescriptor(keyPath: \Topic.title_, ascending: true)]
        request.predicate = predicate
        return request
    }
}
