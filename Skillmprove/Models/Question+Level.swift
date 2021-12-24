//
//  Question+Level.swift
//  Skillmprove
//
//  Created by Pavel Vaitsikhouski on 24.12.21.
//

import Foundation

extension Question {
    static var EASY: String { "Easy" }
    static var MIDDLE: String { "Middle" }
    static var HARD: String { "Hard" }
    
    enum Level {
        case easy, middle, hard
        
        init?(value: String) {
            switch value {
            case Question.EASY: self = .easy
            case Question.MIDDLE: self = .middle
            case Question.HARD: self = .hard
            default: return nil
            }
        }
        
        var key: String {
            switch self {
            case .easy:
                return Question.EASY
            case .middle:
                return Question.MIDDLE
            case .hard:
                return Question.HARD
            }
        }
    }
}
