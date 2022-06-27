//
//  SearchViewModel.swift
//  RickAndMortyWiki
//
//  Created by jyb on 2022/06/27.
//

import Foundation
import RxSwift

enum SearchType: String {
    case character = "Character"
    case location = "Location"
    case episode = "Episode"
}

class SearchViewModel {
    var results = BehaviorSubject<[CanSearch]>(value: [])
    
    let placeHolderText = BehaviorSubject<String>(value: "Search")
    let type: SearchType
    let repository: SearchRepository
    
    private let disposeBag = DisposeBag()
    
    init(type: SearchType, repository: SearchRepository) {
        self.type = type
        self.repository = repository
    
        placeHolderText.onNext("\(type.rawValue) Search")
    }
    
    func search(text: String) {
        switch type {
        case .character:
            repository.getCharacters(name: text).subscribe {
                self.results.onNext($0.results)
            }
            .disposed(by: disposeBag)
        case .location:
            repository.getLocations(name: text).subscribe {
                self.results.onNext($0.results)
            }
            .disposed(by: disposeBag)
        case .episode:
            repository.getEpisodes(name: text).subscribe {
                self.results.onNext($0.results)
            }
            .disposed(by: disposeBag)
        }
    }
}
