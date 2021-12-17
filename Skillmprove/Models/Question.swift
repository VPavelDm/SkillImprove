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
    var correctAnswer: String {
        get { correctAnswer_! }
        set { correctAnswer_ = newValue }
    }
}
