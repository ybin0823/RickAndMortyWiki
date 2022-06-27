//
//  MainTabBarController.swift
//  RickAndMortyWiki
//
//  Created by jyb on 2022/06/27.
//

import UIKit
import RxSwift

class MainTabBarController: UITabBarController {
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ApiService.shared.get(Character.self, path: "/character/1").subscribe(onNext: {
            print($0)
        }).disposed(by: disposeBag)
        
    }
}
