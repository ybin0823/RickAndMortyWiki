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
    var episode = PublishSubject<Episode?>()
    let placeHolderText = BehaviorSubject<String>(value: "Search")
    let type: SearchType
    let repository: EpisodeRepository
    
    private let disposeBag = DisposeBag()
    
    init(type: SearchType, repository: EpisodeRepository) {
        self.type = type
        self.repository = repository
    
        placeHolderText.onNext("\(type.rawValue) Search")
    }
    
    func search(id: Int) {
        repository.getEpisode(id: id)
            .catchAndReturn(nil)
            .subscribe {
            self.episode.onNext($0)
        }
        .disposed(by: disposeBag)
    }
}
