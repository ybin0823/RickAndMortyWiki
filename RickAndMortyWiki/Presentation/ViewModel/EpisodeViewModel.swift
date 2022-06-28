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
    private var info: Info?
    
    init(repository: EpisodeRepository) {
        self.repository = repository
        reloadData()
    }
    
    func reloadData() {
        repository.getEpisodes().subscribe(onNext: {
            self.episodes.onNext($0.results)
            self.info = $0.info
        })
        .disposed(by: disposeBag)
    }
    
    func loadMore() {
        if let info = self.info, let next = info.next {
            repository.getNextEpisodes(url: next)
                .subscribe(onNext: {
                let newValue = try? self.episodes.value() + $0.results
                self.episodes.onNext(newValue ?? [])
                self.info = $0.info
            })
            .disposed(by: disposeBag)
        }
    }
}
