//
//  Question+Level.swift
//  Skillmprove
//
//  Created by Pavel Vaitsikhouski on 24.12.21.
//

import Foundation

extension Question {
    static var EASY: String { "Easy" }
    static var MEDIUM: String { "Medium" }
    static var HARD: String { "Hard" }
    
    enum Level {
        case easy, medium, hard
        
        init?(value: String) {
            switch value {
            case Question.EASY: self = .easy
            case Question.MEDIUM: self = .medium
            case Question.HARD: self = .hard
            default: return nil
            }
        }
        
        var key: String {
            switch self {
            case .easy:
                return Question.EASY
            case .medium:
                return Question.MEDIUM
            case .hard:
                return Question.HARD
            }
        }
    }
}
