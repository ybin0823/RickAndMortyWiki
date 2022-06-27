//
//  File.swift
//  RickAndMortyWiki
//
//  Created by jyb on 2022/06/27.
//

import Foundation
import RxSwift

protocol CharacterRepository {
    func getCharacters() -> Observable<Characters>
}

class CharacterRepositoryImpl: CharacterRepository {
    func getCharacters() -> Observable<Characters> {
        ApiService.shared.get(Characters.self, path: "/character")
    }
}
