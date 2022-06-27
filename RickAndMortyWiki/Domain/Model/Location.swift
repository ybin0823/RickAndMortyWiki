//
//  Location.swift
//  RickAndMortyWiki
//
//  Created by jyb on 2022/06/27.
//

import Foundation

struct Location: Codable {
    let id: Int
    let name: String
    let type: String
    let dimension: String
    let url: String
    let created: String
    let residents: [String]
}

struct Locations: Codable {
    let results: [Location]
}
