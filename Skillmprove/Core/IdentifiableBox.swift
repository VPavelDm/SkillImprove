//
//  IdentifiableBox.swift
//  Skillmprove
//
//  Created by Pavel Vaitsikhouski on 15.12.21.
//

import Foundation

class IdentifiableBox<T>: Identifiable {
    var value: T
    
    init(value: T) {
        self.value = value
    }
}
