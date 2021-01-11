//
//  PlayerCell.swift
//  PT FDS Albert
//
//  Created by Albert on 10/1/21.
//

import UIKit

class PlayerCell: UITableViewCell {

    @IBOutlet weak var playerImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var ageLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        playerImageView.layer.cornerRadius = playerImageView.frame.height/2
            playerImageView.contentMode = .scaleAspectFit
    }
    
    
    override func prepareForReuse() {
        playerImageView.image = nil
        nameLabel.text = ""
        ageLabel.text = ""
    }
    
}
