//
//  CoreDataExtensions.swift
//  Skillmprove
//
//  Created by Pavel Vaitsikhouski on 15.12.21.
//

import Foundation
import CoreData

extension NSPredicate {
    static var all = NSPredicate(format: "TRUEPREDICATE")
    static var none = NSPredicate(format: "FALSEPREDICATE")
}

extension NSOrderedSet {
    func toArray<T>() -> [T] {
        assert(array is [T], "Can't cast NSOrderedSet to Array")
        return array as? [T] ?? []
    }
}

extension Array {
    var nsOrderedSet: NSOrderedSet {
        NSOrderedSet(array: self)
    }
}
