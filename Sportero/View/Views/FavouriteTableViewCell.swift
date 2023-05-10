//
//  BasketballTableViewCell.swift
//  Sportero
//
//  Created by Asalah Sayed on 02/05/2023.
//

import UIKit

class FavouriteTableViewCell: UITableViewCell {
    @IBOutlet weak var favouriteView: UIView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var sportLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
