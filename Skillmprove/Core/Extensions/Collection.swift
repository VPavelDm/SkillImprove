//
//  Collection.swift
//  Skillmprove
//
//  Created by Pavel Vaitsikhouski on 18.12.21.
//

import Foundation

extension Collection {
    func unique() -> [Element] where Element: Hashable {
        var buffer = [Element]()
        var added = Set<Element>()
        for elem in self {
            if !added.contains(elem) {
                buffer.append(elem)
                added.insert(elem)
            }
        }
        return buffer
    }
}
