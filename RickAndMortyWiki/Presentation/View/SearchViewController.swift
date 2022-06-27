//
//  SearchViewController.swift
//  RickAndMortyWiki
//
//  Created by jyb on 2022/06/27.
//

import UIKit
import RxCocoa

class SearchViewController: UIViewController {
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var emptyView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addTabGestureForHideKeyboard()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        searchTextField.becomeFirstResponder()
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
}
