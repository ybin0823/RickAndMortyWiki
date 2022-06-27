//
//  LocationViewController.swift
//  RickAndMortyWiki
//
//  Created by jyb on 2022/06/27.
//

import UIKit
import RxSwift

class LocationViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    private let disposeBag = DisposeBag()
    
    let viewModel = LocationViewModel(repository: LocationRepositoryImpl())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bindViewModel()
    }
    
    private func bindViewModel() {
        viewModel.locations.bind(to: tableView.rx.items) { tableView, index, item in
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "LocationCell") else { return UITableViewCell() }
            cell.textLabel?.text = item.name
            
            return cell
        }.disposed(by: disposeBag)
    }
}
