//
//  DetailViewController.swift
//  RickAndMortyWiki
//
//  Created by jyb on 2022/06/28.
//

import UIKit
import RxSwift
import Kingfisher

class DetailViewController: UIViewController {
    var id: Int?
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var imageView: UIImageView!
    
    var viewModel: DetailViewModel!
    
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bindViewModel()
    }
    
    private func bindViewModel() {
        viewModel.character.subscribe(onNext: { [weak self] result in

            self?.imageView.kf.setImage(with: URL(string: result.image), options: [.transition(ImageTransition.fade(1))])
        }).disposed(by: disposeBag)

        viewModel.character.subscribe(onNext: { [weak self] item in
            let sections = [
                "Status": item.status.rawValue,
                "Species": item.species,
                "Name": item.name,
                "Gender": item.gender.rawValue
            ]

            //FIXME: - 노출 순서가 랜덤으로 나옴
            for (index, section) in sections.enumerated() {
                let view = DetailSection(frame: CGRect())
                view.titleLabel.text = section.key
                view.descriptionLabel.text = section.value

                self?.scrollView.addSubview(view)

                view.translatesAutoresizingMaskIntoConstraints = false
                let spacing = 20 + 100 * index
                NSLayoutConstraint(item: view, attribute: .top, relatedBy: .equal, toItem: self?.imageView, attribute: .bottom, multiplier: 1, constant: CGFloat(spacing)).isActive = true
            }
        }).disposed(by: disposeBag)
    }
}
