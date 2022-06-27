//
//  MainTabBarController.swift
//  RickAndMortyWiki
//
//  Created by jyb on 2022/06/27.
//

import UIKit

class MainTabBarController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupChildViewControllers()
    }
    
    private func setupChildViewControllers() {
        guard let viewControllers = viewControllers else {
            return
        }

        for viewController in viewControllers {
            switch viewController {
            case let viewController as CharacterViewController:
                // do nothing
                print("viewModel repository injection??")
            default:
                break
            }
        }
    }
}
