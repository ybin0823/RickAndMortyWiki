//
//  SearchResultView.swift
//  RickAndMortyWiki
//
//  Created by jyb on 2022/06/27.
//

import UIKit

class SearchResultView: UIView {
    var model: Episode? {
        didSet {
            nameLabel?.text = model?.name
            episodeLabel?.text = model?.episode
        }
    }
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var episodeLabel: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        customInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        customInit()
    }
    
    func customInit() {
        if let view = Bundle.main.loadNibNamed("SearchResultView", owner: self, options: nil)?.first as? UIView {
            view.frame = self.bounds
            addSubview(view)
        }
    }
}
