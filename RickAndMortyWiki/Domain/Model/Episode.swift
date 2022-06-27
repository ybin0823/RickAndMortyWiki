//
//  Episode.swift
//  RickAndMortyWiki
//
//  Created by jyb on 2022/06/27.
//

import Foundation

struct Episode: Codable {
    let id: Int
    let name: String
    let air_date: String
    let episode: String
    let created: String
    let url: String
    let characters: [String]
}

struct Episodes: Codable {
    let results: [Episode]
}
