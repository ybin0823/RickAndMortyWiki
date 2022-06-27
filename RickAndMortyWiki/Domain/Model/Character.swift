//
//  Character.swift
//  RickAndMortyWiki
//
//  Created by jyb on 2022/06/27.
//

import Foundation

enum CharacterStatus: String, Codable {
    case alive = "Alive"
    case dead = "Dead"
    case unknown
}

enum Gender: String, Codable {
    case male = "Male"
    case female = "Female"
    case genderless = "Genderless"
    case unknown
}

struct Character: Codable {
    let id: Int
    let name: String
    let status: CharacterStatus
    let species: String
    let type: String
    let gender: Gender
    let url: String
    let created: String
    let image: String
//    let episode: [String]
}

struct CharcaterOrigin {
    let name: String
    let url: String
}

struct CharacterLocation {
    let name: String
    let url: String
}

struct Characters: Codable {
    let results: [Character]
}
