//
//  SearchViewModel.swift
//  RickAndMortyWiki
//
//  Created by jyb on 2022/06/27.
//

import Foundation
import RxSwift

enum SearchType: String {
    case character = "Character"
    case location = "Location"
    case episode = "Episode"
}

class SearchViewModel {
    var results = BehaviorSubject<[CanSearch]>(value: [])
    
    let placeHolderText = BehaviorSubject<String>(value: "Search")
    let type: SearchType
    let repository: SearchRepository
    
    private let disposeBag = DisposeBag()
    private var info: Info?
    
    init(type: SearchType, repository: SearchRepository) {
        self.type = type
        self.repository = repository
        
        placeHolderText.onNext("\(type.rawValue) Search")
    }
    
    func search(text: String) {
        switch type {
        case .character:
            repository.getCharacters(name: text).subscribe(onNext: {
                self.results.onNext($0.results)
                self.info = $0.info
            }).disposed(by: disposeBag)
        case .location:
            repository.getLocations(name: text).subscribe(onNext: {
                self.results.onNext($0.results)
                self.info = $0.info
            }).disposed(by: disposeBag)
        case .episode:
            repository.getEpisodes(name: text).subscribe(onNext: {
                self.results.onNext($0.results)
                self.info = $0.info
            }).disposed(by: disposeBag)
        }
    }
    
    func loadMore() {
        if let info = self.info, let next = info.next {
            switch type {
            case .character:
                repository.getNextCharacters(url: next).subscribe(onNext: {
                    let newValue = try? self.results.value() + $0.results
                    self.results.onNext(newValue ?? [])
                    self.info = $0.info
                }).disposed(by: disposeBag)
            case .location:
                repository.getNextLocations(url: next).subscribe(onNext: {
                    let newValue = try? self.results.value() + $0.results
                    self.results.onNext(newValue ?? [])
                    self.info = $0.info
                }).disposed(by: disposeBag)
            case .episode:
                repository.getNextEpisodes(url: next).subscribe(onNext: {
                    let newValue = try? self.results.value() + $0.results
                    self.results.onNext(newValue ?? [])
                    self.info = $0.info
                }).disposed(by: disposeBag)
            }
        }
    }
}
