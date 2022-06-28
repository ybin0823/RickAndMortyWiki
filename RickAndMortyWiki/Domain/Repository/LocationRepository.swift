//
//  LocationRepository.swift
//  RickAndMortyWiki
//
//  Created by jyb on 2022/06/27.
//

import Foundation
import RxSwift

protocol LocationRepository {
    func getLocations() -> Observable<Locations>
    func getNextLocations(url: String) -> Observable<Locations>
}

class LocationRepositoryImpl: LocationRepository {
    func getLocations() -> Observable<Locations> {
        ApiService.shared.get(Locations.self, path: "/location")
    }
    
    func getNextLocations(url: String) -> Observable<Locations> {
        ApiService.shared.get(Locations.self, url: url)
    }
}
