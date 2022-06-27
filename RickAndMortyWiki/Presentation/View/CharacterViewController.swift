//
//  CharacterViewController.swift
//  RickAndMortyWiki
//
//  Created by jyb on 2022/06/27.
//

import UIKit
import RxSwift
import RxCocoa

class CharacterViewController: UIViewController {
    let disposeBag = DisposeBag()
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ApiService.shared.get(Characters.self, path: "/character")
            .map {
                $0.results
            }.bind(to: tableView.rx.items) { tableView, index, item in
                guard let cell = tableView.dequeueReusableCell(withIdentifier: "CharacterCell") else { return UITableViewCell() }
                cell.textLabel?.text = item.name
                return cell
            }.disposed(by: disposeBag)
    }
}
