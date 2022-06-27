//
//  LocationViewModel.swift
//  RickAndMortyWiki
//
//  Created by jyb on 2022/06/27.
//

import Foundation
import RxSwift

class LocationViewModel {
    var locations = BehaviorSubject<[Location]>(value: [])
    let repository: LocationRepository
    
    private let disposeBag = DisposeBag()
    
    init(repository: LocationRepository) {
        self.repository = repository
        reloadData()
    }
    
    func reloadData() {
        repository.getLocations().map {
            $0.results
        }.subscribe {
            self.locations.onNext($0)
        }
        .disposed(by: disposeBag)
    }
}
