//
//  SearchRepository.swift
//  RickAndMortyWiki
//
//  Created by jyb on 2022/06/27.
//

import Foundation
import RxSwift

protocol SearchRepository {
    //TODO: - filter(name, status, species, type, gender)
    func getCharacters(name: String) -> Observable<Characters>
    func getNextCharacters(url: String) -> Observable<Characters>
    
    
    //TODO: - filter(name, type, dimension)
    func getLocations(name: String) -> Observable<Locations>
    func getNextLocations(url: String) -> Observable<Locations>
    
    
    //TODO: - filter(name, episode)
    func getEpisodes(name: String) -> Observable<Episodes>
    func getNextEpisodes(url: String) -> Observable<Episodes>
}

class SearchRepositoryImpl: SearchRepository {
    
    func getCharacters(name: String) -> Observable<Characters> {
        ApiService.shared.get(Characters.self, path: "/character", param: ["name": name])
    }
    
    func getNextCharacters(url: String) -> Observable<Characters> {
        ApiService.shared.get(Characters.self, url: url)
    }
    
    
    func getLocations(name: String) -> Observable<Locations> {
        ApiService.shared.get(Locations.self, path: "/location", param: ["name": name])
    }
    
    func getNextLocations(url: String) -> Observable<Locations> {
        ApiService.shared.get(Locations.self, url: url)
    }
    
    func getEpisodes(name: String) -> Observable<Episodes> {
        ApiService.shared.get(Episodes.self, path: "/episode", param: ["name": name])
    }
    
    func getNextEpisodes(url: String) -> Observable<Episodes> {
        ApiService.shared.get(Episodes.self, url: url)
    }
}
