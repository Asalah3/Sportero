//
//  PlayerTableViewCell.swift
//  Sportero
//
//  Created by Asalah Sayed on 05/05/2023.
//

import UIKit

class PlayerTableViewCell: UITableViewCell {

    @IBOutlet weak var playerImage: UIImageView!
    
    @IBOutlet weak var playerName: UILabel!
    
    @IBOutlet weak var playerNumber: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
