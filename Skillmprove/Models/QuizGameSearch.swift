//
//  QuizGameSearch.swift
//  Skillmprove
//
//  Created by Pavel Vaitsikhouski on 17.12.21.
//

import Foundation
import CoreData

struct QuizGameSearch: Equatable {
    var iOS: Bool = false
    var uiKit: Bool = false
    var swiftUI: Bool = false
    var objC: Bool = false
    
    var predicate: NSPredicate {
        var formatComponents: [String] = []
        var args: [Any] = []
        if iOS {
            formatComponents.append("category_ CONTAINS %@")
            args.append("iOS")
        }
        if uiKit {
            formatComponents.append("category_ CONTAINS %@")
            args.append("UIKit")
        }
        if swiftUI {
            formatComponents.append("category_ CONTAINS %@")
            args.append("SwiftUI")
        }
        if objC {
            formatComponents.append("category_ CONTAINS %@")
            args.append("Objective-C")
        }
        let format = formatComponents.joined(separator: " and ")
        return format.isEmpty ? .all : NSPredicate(format: format, argumentArray: args)
    }
}
