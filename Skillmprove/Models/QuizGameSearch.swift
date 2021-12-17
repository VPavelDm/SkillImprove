//
//  QuizGameSearch.swift
//  Skillmprove
//
//  Created by Pavel Vaitsikhouski on 17.12.21.
//

import Foundation
import CoreData

struct QuizGameSearch {
    var filters: [String] = []
    
    var predicate: NSPredicate {
        let format = filters
            .map { "\($0) = true" }
            .joined(separator: " and ")
        return format.isEmpty ? .all : NSPredicate(format: format)
    }
}
