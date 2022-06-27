//
//  CharactersViewModel.swift
//  RickAndMortyWiki
//
//  Created by jyb on 2022/06/27.
//

import Foundation
import RxSwift

class CharactersViewModel {
    static let shared = CharactersViewModel()
    var characters = BehaviorSubject<[Character]>(value: [])
    
    private let disposeBag = DisposeBag()
    
    init() {
        reloadData()
    }
    
    func reloadData() {
        // Observable<Data> --> subscribe --> members
        ApiService.shared.get(Characters.self, path: "/character")
            .map {
                $0.results
            }.subscribe {
                self.characters.onNext($0)
            }
            .disposed(by: disposeBag)
    }
}
