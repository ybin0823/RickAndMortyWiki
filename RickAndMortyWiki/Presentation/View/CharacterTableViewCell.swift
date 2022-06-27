//
//  CharacterTableViewCell.swift
//  RickAndMortyWiki
//
//  Created by jyb on 2022/06/27.
//

import UIKit

class CharacterTableViewCell: UITableViewCell {
    var status: CharacterStatus? {
        didSet {
            switch status {
            case .alive:
                statusLabel.textColor = .green
            case .dead:
                statusLabel.textColor = .red
            case .unknown:
                statusLabel.textColor = .black
            default:
                break
            }
            
        }
    }
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var thumbnailView: UIImageView!
    @IBOutlet weak var statusLabel: UILabel!
}
