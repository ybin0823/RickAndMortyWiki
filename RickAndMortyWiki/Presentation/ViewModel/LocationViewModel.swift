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
    private var info: Info?
    
    init(repository: LocationRepository) {
        self.repository = repository
        reloadData()
    }
    
    func reloadData() {
        repository.getLocations().subscribe(onNext: {
            self.locations.onNext($0.results)
            self.info = $0.info
        })
        .disposed(by: disposeBag)
    }
    
    func loadMore() {
        if let info = self.info, let next = info.next {
            repository.getNextLocations(url: next)
                .subscribe(onNext: {
                let newValue = try? self.locations.value() + $0.results
                self.locations.onNext(newValue ?? [])
                self.info = $0.info
            })
            .disposed(by: disposeBag)
        }
    }
}
