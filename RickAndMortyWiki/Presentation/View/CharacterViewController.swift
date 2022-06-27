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
    let viewModel = CharactersViewModel(repository: CharacterRepositoryImpl())
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bindViewModel()
    }
    
    private func bindViewModel() {
        viewModel.characters.bind(to: tableView.rx.items) { tableView, index, item in
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "CharacterCell") else { return UITableViewCell() }
            cell.textLabel?.text = item.name
            return cell
        }.disposed(by: disposeBag)
    }
}
