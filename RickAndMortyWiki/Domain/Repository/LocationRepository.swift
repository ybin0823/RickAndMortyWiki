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
}

class LocationRepositoryImpl: LocationRepository {
    func getLocations() -> Observable<Locations> {
        ApiService.shared.get(Locations.self, path: "/location")
    }
}
