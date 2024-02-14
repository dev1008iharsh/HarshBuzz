//
//  PlayerListTVC.swift
//  HarshBuzz
//
//  Created by My Mac Mini on 14/02/24.
//

import UIKit

class PlayerListTVC: UITableViewCell {
    @IBOutlet weak var lblPlayer: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    override func prepareForReuse() {
        super.prepareForReuse()
        lblPlayer.text = nil
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
