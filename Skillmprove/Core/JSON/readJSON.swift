//
//  readJSON.swift
//  Skillmprove
//
//  Created by Pavel Vaitsikhouski on 15.12.21.
//

import Foundation

enum ReadJSONError: Error {
    case incorrectPath
    case noData
    case incorrectDataFormat
}

func readJSON<Item>(path: String) throws -> Item where Item: Decodable {
    guard let path = Bundle.main.url(forResource: path, withExtension: "json") else {
        throw ReadJSONError.incorrectPath
    }
    let data = try Data(contentsOf: path)
    let decoder = JSONDecoder()
    let item = try decoder.decode(Item.self, from: data)
    return item
}
