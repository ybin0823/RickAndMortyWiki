//
//  LocationViewController.swift
//  RickAndMortyWiki
//
//  Created by jyb on 2022/06/27.
//

import UIKit
import RxSwift

class LocationViewController: UIViewController, LoadMore {
    @IBOutlet weak var tableView: UITableView!
    
    private let disposeBag = DisposeBag()
    
    let viewModel = LocationViewModel(repository: LocationRepositoryImpl())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.rx.loadMore.subscribe(onNext: { [weak self] isLoadMore in
            if isLoadMore {
                self?.loadMore()
            }
        }).disposed(by: disposeBag)
        
        bindViewModel()
    }
    
    private func bindViewModel() {
        viewModel.locations.bind(to: tableView.rx.items) { tableView, index, item in
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "LocationCell") else { return UITableViewCell() }
            cell.textLabel?.text = item.name
            
            return cell
        }.disposed(by: disposeBag)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let searchViewController = segue.destination as? SearchViewController {
            searchViewController.viewModel = SearchViewModel(type: .location, repository: SearchRepositoryImpl())
        }
    }
    
    func loadMore() {
        viewModel.loadMore()
    }
}
