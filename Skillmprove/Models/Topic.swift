//
//  Topic.swift
//  Skillmprove
//
//  Created by Pavel Vaitsikhouski on 14.12.21.
//

import Foundation

struct Topic: Identifiable {
    var id: String { title }
    var url: URL
    var title: String
}
