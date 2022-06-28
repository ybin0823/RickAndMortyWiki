//
//  ApiService.swift
//  RickAndMortyWiki
//
//  Created by jyb on 2022/06/27.
//

import Foundation
import RxAlamofire
import RxSwift

struct APIError: LocalizedError {
    let value: String
}

class ApiService {
    static let shared = ApiService()
    
    private init() {}
    
    let baseUrl = "https://rickandmortyapi.com/api"
    
    func get<T: Codable>(_ t: T.Type, url: String, param: [String: Any]? = nil) -> Observable<T> {
        return RxAlamofire.request(.get,
                                   url, parameters: param)
            .validate(statusCode: 100..<300)
            .data()
            .flatMap { data in
                Observable.create { observer in
                    guard let result = try? JSONDecoder().decode(T.self, from: data) else {
                        observer.onError(APIError(value: "Parsing Error"))
                        return Disposables.create()
                    }
                    observer.onNext(result)
                    return Disposables.create()
                }
            }
    }
    
    func get<T: Codable>(_ t: T.Type, path: String, param: [String: Any]? = nil) -> Observable<T> {
        self.get(t, url: baseUrl + path, param: param)
    }
}
