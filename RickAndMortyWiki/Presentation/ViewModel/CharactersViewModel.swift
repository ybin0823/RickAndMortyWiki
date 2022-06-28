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
    private var info: Info?
    
    init(repository: CharacterRepository) {
        self.repository = repository
        reloadData()
    }
    
    func reloadData() {
        repository.getCharacters().subscribe(onNext: {
            self.characters.onNext($0.results)
            self.info = $0.info
        })
        .disposed(by: disposeBag)
    }
    
    func loadMore() {
        if let info = self.info, let next = info.next {
            repository.getNextCharacters(url: next).subscribe(onNext: {
                let newValue = try? self.characters.value() + $0.results
                self.characters.onNext(newValue ?? [])
                self.info = $0.info
            })
            .disposed(by: disposeBag)
        }
    }
}
