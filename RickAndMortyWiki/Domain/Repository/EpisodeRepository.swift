//
//  EpisodeRepository.swift
//  RickAndMortyWiki
//
//  Created by jyb on 2022/06/27.
//

import Foundation
import RxSwift

protocol EpisodeRepository {
    func getEpisodes() -> Observable<Episodes>
}

class EpisodeRepositoryImpl: EpisodeRepository {
    func getEpisodes() -> Observable<Episodes> {
        ApiService.shared.get(Episodes.self, path: "/episode")
    }
}
