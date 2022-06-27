//
//  EpisodeViewModel.swift
//  RickAndMortyWiki
//
//  Created by jyb on 2022/06/27.
//

import Foundation
import RxSwift

class EpisodeViewModel {
    var episodes = BehaviorSubject<[Episode]>(value: [])
    let repository: EpisodeRepository
    
    private let disposeBag = DisposeBag()
    
    init(repository: EpisodeRepository) {
        self.repository = repository
        reloadData()
    }
    
    func reloadData() {
        repository.getEpisodes().map {
            $0.results
        }.subscribe {
            self.episodes.onNext($0)
        }
        .disposed(by: disposeBag)
    }
}
