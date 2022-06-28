//
//  Info.swift
//  RickAndMortyWiki
//
//  Created by jyb on 2022/06/28.
//

import Foundation

struct Info: Codable {
    let count: Int
    let pages: Int
    let next: String?
    let prev: String?
}
