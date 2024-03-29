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
    func getNextCharacters(url: String) -> Observable<Characters>
    func getCharacter(id: Int) -> Observable<Character>
}

class CharacterRepositoryImpl: CharacterRepository {
    func getCharacters() -> Observable<Characters> {
        ApiService.shared.get(Characters.self, path: "/character")
    }
    
    func getNextCharacters(url: String) -> Observable<Characters> {
        ApiService.shared.get(Characters.self, url: url)
    }
    
    func getCharacter(id: Int) -> Observable<Character> {
        ApiService.shared.get(Character.self, path: "/character/\(id)")
    }
}
