//
//  RickAndMortyWikiTests.swift
//  RickAndMortyWikiTests
//
//  Created by jyb on 2022/06/26.
//

import XCTest
import RxSwift
import RxBlocking
@testable import RickAndMortyWiki


class MockCharacterRepositoy: CharacterRepository {
    func getCharacters() -> Observable<Characters> {
        return Observable.just(Characters(info: Info(count: 0, pages: 0, next: nil, prev: nil), results: []))
    }
    
    func getNextCharacters(url: String) -> Observable<Characters> {
        return Observable.just(Characters(info: Info(count: 0, pages: 0, next: nil, prev: nil), results: []))
    }
    
    func getCharacter(id: Int) -> Observable<Character> {
        return Observable.just(Character(id: 0, name: "", status: .unknown, species: "", type: "", gender: .unknown, url: "", created: "", image: ""))
    }
    
    
}

//TODO: - created를 ui맞춰서 formatting을 한다면 사용하기 좋을 것 같음
class RickAndMortyWikiTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
        
        let viewModel = CharactersViewModel(repository: MockCharacterRepositoy())
        do {
            let result = try viewModel.characters.toBlocking(timeout: nil).first()
            XCTAssertTrue(result!.isEmpty)
        } catch {
            
        }
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
