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
    var onlyFavorites: Bool = false
    var easy: Bool = true
    var medium: Bool = true
    var hard: Bool = true
    
    // MARK: - Inits
    init(_ filters: [String] = []) {
        self.filters = filters
        self.toggles = []
        setupToggles()
    }
    
    // MARK: - DB
    private mutating func setupToggles() {
        
        // favorites
        UserDefaults.standard.register(defaults: [FAVORITES: true])
        onlyFavorites = UserDefaults.standard.bool(forKey: FAVORITES)
        
        // complexity
        let levels = [Question.EASY, Question.MEDIUM, Question.HARD]
        UserDefaults.standard.register(defaults: Dictionary(uniqueKeysWithValues: levels.map({ ($0, true) })))
        easy = UserDefaults.standard.bool(forKey: Question.EASY)
        medium = UserDefaults.standard.bool(forKey: Question.MEDIUM)
        hard = UserDefaults.standard.bool(forKey: Question.HARD)
        
        // categories
        UserDefaults.standard.register(defaults: Dictionary(uniqueKeysWithValues: filters.map({ ($0, true) })))
        for filter in filters {
            toggles.append(UserDefaults.standard.bool(forKey: filter))
        }
    }
    func saveToggles() {
        for index in filters.indices {
            UserDefaults.standard.set(toggles[index], forKey: filters[index])
        }
        UserDefaults.standard.set(easy, forKey: Question.EASY)
        UserDefaults.standard.set(medium, forKey: Question.MEDIUM)
        UserDefaults.standard.set(hard, forKey: Question.HARD)
        UserDefaults.standard.set(onlyFavorites, forKey: FAVORITES)
    }
    
    // MARK: - Predicate Utils
    var predicate: NSPredicate {
        guard let categoryFormat = categoryFormat else { return .none }
        guard let levelFormat = levelFormat else { return .none }
        let components = [favoriteFormat, categoryFormat, levelFormat]
        let format = components
            .map { $0.format }
            .joined(separator: " and ")
        let args = components
            .flatMap { $0.args}
        return NSPredicate(format: format, argumentArray: args)
    }
    private var favoriteFormat: (format: String, args: [Any]) {
        if onlyFavorites {
            return ("(isLiked == %@)", [onlyFavorites])
        } else {
            return ("(isShown == %@)", [false])
        }
    }
    private var categoryFormat: (format: String, args: [Any])? {
        var formatComponents: [String] = []
        var args: [Any] = []
        for (index, toggle) in toggles.enumerated() {
            if toggle {
                formatComponents.append("category_ CONTAINS %@")
                args.append(filters[index])
            }
        }
        return formatComponents.isEmpty ? nil : ("(\(formatComponents.joined(separator: " or ")))", args)
    }
    private var levelFormat: (format: String, args: [Any])? {
        var formatComponents: [String] = []
        var args: [String] = []
        if easy {
            formatComponents.append("level_ == %@")
            args.append(Question.EASY)
        }
        if medium {
            formatComponents.append("level_ == %@")
            args.append(Question.MEDIUM)
        }
        if hard {
            formatComponents.append("level_ == %@")
            args.append(Question.HARD)
        }
        return formatComponents.isEmpty ? nil : ("(\(formatComponents.joined(separator: " or ")))", args)
    }
    
    // MARK: - Constants
    private let FAVORITES = "favorites"
}
