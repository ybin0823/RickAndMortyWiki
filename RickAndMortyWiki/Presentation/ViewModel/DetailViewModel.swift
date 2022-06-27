//
//  DetailViewModel.swift
//  RickAndMortyWiki
//
//  Created by jyb on 2022/06/28.
//

import Foundation
import RxSwift

class DetailViewModel {
    var character = PublishSubject<Character>()
    
    private let id: Int
    private let repository: CharacterRepository
    private let disposeBag = DisposeBag()
    
    init(id: Int, repository: CharacterRepository) {
        self.id = id
        self.repository = repository
        
        reloadData()
    }
    
    func reloadData() {
        repository.getCharacter(id: self.id).subscribe { [weak self] result in
            self?.character.onNext(result)
        }.disposed(by: disposeBag)
    }
}
