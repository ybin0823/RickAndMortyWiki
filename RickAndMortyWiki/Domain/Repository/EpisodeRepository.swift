//
//  EpisodeRepository.swift
//  RickAndMortyWiki
//
//  Created by jyb on 2022/06/27.
//

import Foundation
import RxSwift

protocol EpisodeRepository {
    func getEpisode(id: Int) -> Observable<Episode?>
}

class EpisodeRepositoryImpl: EpisodeRepository {
    func getEpisode(id: Int) -> Observable<Episode?> {
        ApiService.shared.get(Episode?.self, path: "/episode/\(id)")
    }
}
