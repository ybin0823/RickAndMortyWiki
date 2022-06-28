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
    
    //TODO: - search 시 404 에러는 어떻게 처리하면 좋을지..?
    // ApiService에서 공통으로 처리하면 empty가 아닌 url path를 잘못 입력한 경우를 알기가 어려움
    // Info를 nullable로 처리하면 응답이 마치 nullable일 듯한 의미가 되기 때문에 적합하지 않아보임
    func search(text: String) {
        switch type {
        case .character:
            repository.getCharacters(name: text)
                .catchAndReturn(Characters(info: Info(count: 0, pages: 0, next: nil, prev: nil), results: []))
                .subscribe(onNext: {
                self.results.onNext($0.results)
                self.info = $0.info
            }).disposed(by: disposeBag)
        case .location:
            repository.getLocations(name: text)
                .catchAndReturn(Locations(info: Info(count: 0, pages: 0, next: nil, prev: nil), results: []))
                .subscribe(onNext: {
                self.results.onNext($0.results)
                self.info = $0.info
            }).disposed(by: disposeBag)
        case .episode:
            repository.getEpisodes(name: text)
                .catchAndReturn(Episodes(info: Info(count: 0, pages: 0, next: nil, prev: nil), results: []))
                .subscribe(onNext: {
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
