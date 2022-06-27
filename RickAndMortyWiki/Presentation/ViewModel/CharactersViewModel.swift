//
//  CharactersViewModel.swift
//  RickAndMortyWiki
//
//  Created by jyb on 2022/06/27.
//

import Foundation
import RxSwift

class CharactersViewModel {
    var characters = BehaviorSubject<[Character]>(value: [])
    let repository: CharacterRepository
    
    private let disposeBag = DisposeBag()
    
    init(repository: CharacterRepository) {
        self.repository = repository
        reloadData()
    }
    
    func reloadData() {
        repository.getCharacters().map {
            $0.results
        }.subscribe {
            self.characters.onNext($0)
        }
        .disposed(by: disposeBag)
    }
}
