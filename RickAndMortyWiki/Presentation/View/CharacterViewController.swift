//
//  CharacterViewController.swift
//  RickAndMortyWiki
//
//  Created by jyb on 2022/06/27.
//

import UIKit
import RxSwift
import RxCocoa
import Kingfisher

class CharacterViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    let viewModel = CharactersViewModel(repository: CharacterRepositoryImpl())
    
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.register(UINib(nibName: "CharacterTableViewCell", bundle: nil), forCellReuseIdentifier: "CharacterCell")
        bindViewModel()
    }
    
    private func bindViewModel() {
        viewModel.characters.bind(to: tableView.rx.items) { tableView, index, item in
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "CharacterCell") as? CharacterTableViewCell else { return UITableViewCell() }
            cell.thumbnailView.kf.setImage(with: URL(string: item.image))
            cell.nameLabel?.text = item.name
            cell.statusLabel?.text = item.status.rawValue
            
            return cell
        }.disposed(by: disposeBag)
    }
}
