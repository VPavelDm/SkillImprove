//
//  QuizGameSearch.swift
//  Skillmprove
//
//  Created by Pavel Vaitsikhouski on 17.12.21.
//

import Foundation
import CoreData

struct QuizGameSearch: Equatable {
    private(set) var filters: [String]
    var toggles: [Bool]
    
    init(_ filters: [String] = []) {
        self.filters = filters
        self.toggles = Array(repeating: true, count: filters.count)
    }
    
    var predicate: NSPredicate {
        var formatComponents: [String] = []
        var args: [Any] = []
        
        for (index, toggle) in toggles.enumerated() {
            if toggle {
                formatComponents.append("category_ CONTAINS %@")
                args.append(filters[index])
            }
        }
        let format = formatComponents.joined(separator: " or ")
        return format.isEmpty ? .none : NSPredicate(format: format, argumentArray: args)
    }
}
