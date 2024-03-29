//
//  EpisodeViewController.swift
//  RickAndMortyWiki
//
//  Created by jyb on 2022/06/27.
//

import UIKit
import RxSwift

class EpisodeViewController: UIViewController, LoadMore {
    @IBOutlet weak var tableView: UITableView!
    
    private let disposeBag = DisposeBag()
    
    let viewModel = EpisodeViewModel(repository: EpisodeRepositoryImpl())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bindViewModel()
        
        tableView.rx.loadMore
            .throttle(.milliseconds(300), latest: false, scheduler: MainScheduler.instance)
            .subscribe(onNext: { [weak self] isLoadMore in
            if isLoadMore {
                self?.loadMore()
            }
        }).disposed(by: disposeBag)
    }
    
    private func bindViewModel() {
        viewModel.episodes.bind(to: tableView.rx.items) { tableView, index, item in
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "EpisodeCell") else { return UITableViewCell() }
            cell.textLabel?.text = item.name
            cell.detailTextLabel?.text = item.episode
            
            return cell
        }.disposed(by: disposeBag)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let searchViewController = segue.destination as? SearchViewController {
            searchViewController.viewModel = SearchViewModel(type: .episode, repository: SearchRepositoryImpl())
        }
    }
    
    func loadMore() {
        viewModel.loadMore()
    }
}
