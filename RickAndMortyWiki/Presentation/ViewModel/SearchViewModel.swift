//
//  SearchViewModel.swift
//  RickAndMortyWiki
//
//  Created by jyb on 2022/06/27.
//

import Foundation
import RxSwift

class SearchViewModel {
    var episode = PublishSubject<Episode?>()
    let repository: EpisodeRepository
    
    private let disposeBag = DisposeBag()
    
    init(repository: EpisodeRepository) {
        self.repository = repository
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
