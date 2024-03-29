//
//  SearchViewController.swift
//  RickAndMortyWiki
//
//  Created by jyb on 2022/06/27.
//

import UIKit
import RxSwift
import RxCocoa

class SearchViewController: UIViewController, LoadMore {
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var emptyView: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    
    var viewModel: SearchViewModel!
    
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addTabGestureForHideKeyboard()
        
        searchButton.rx.tap.throttle(.milliseconds(500), scheduler: MainScheduler.instance)
            .subscribe(onNext: { [weak self] in
                guard let text = self?.searchTextField.text, !text.isEmpty else {
                    return
                }
                
                self?.viewModel.search(text: text)
            })
            .disposed(by: disposeBag)
        
        tableView.rx.loadMore
            .throttle(.milliseconds(300), latest: false, scheduler: MainScheduler.instance)
            .subscribe(onNext: { [weak self] isLoadMore in
            if isLoadMore {
                self?.loadMore()
            }
        }).disposed(by: disposeBag)
        
        bindViewModel()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        searchTextField.becomeFirstResponder()
    }
    
    private func bindViewModel() {
        viewModel.placeHolderText.bind(to: searchTextField.rx.placeholder).disposed(by: disposeBag)
        viewModel.results.map { $0.isEmpty }.bind(to: tableView.rx.isHidden).disposed(by: disposeBag)
        viewModel.results.map { !$0.isEmpty }.bind(to: emptyView.rx.isHidden).disposed(by: disposeBag)
        
        viewModel.results.bind(to: tableView.rx.items) { tableView, index, item in
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "SearchResultCell") else { return UITableViewCell() }
            
            cell.textLabel?.text = item.name
            
            return cell
        }.disposed(by: disposeBag)

    }
    
    //TODO: - (jyb) RxGesture 가 좋을지
    private func addTabGestureForHideKeyboard() {
        let tapGesture = UITapGestureRecognizer()
        view.addGestureRecognizer(tapGesture)
        tapGesture.addTarget(self, action: #selector(didTapView))
    }
    
    @objc func didTapView() {
        searchTextField.resignFirstResponder()
    }
    
    func loadMore() {
        viewModel.loadMore()
    }
}
