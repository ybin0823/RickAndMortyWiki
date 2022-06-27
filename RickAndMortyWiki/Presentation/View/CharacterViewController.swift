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
        
        Observable.zip(tableView.rx.itemSelected, tableView.rx.modelSelected(Character.self))
            .subscribe(onNext: { [weak self] (indexPath, model) in
                self?.tableView.deselectRow(at: indexPath, animated: false)
                self?.pushDetailViewController(id: model.id)
            })
            .disposed(by: disposeBag)
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
    
    private func pushDetailViewController(id: Int?) {
        if let viewController = UIStoryboard(name: "DetailScreen", bundle: nil).instantiateViewController(withIdentifier: "DetailViewController") as? DetailViewController {
            viewController.id = id
            viewController.viewModel = DetailViewModel(id: id!, repository: CharacterRepositoryImpl())
            
            self.navigationController?.pushViewController(viewController, animated: true)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let searchViewController = segue.destination as? SearchViewController {
            searchViewController.viewModel = SearchViewModel(type: .character, repository: SearchRepositoryImpl())
        }
    }
}
