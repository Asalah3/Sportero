//
//  FootballTableViewCell.swift
//  Sportero
//
//  Created by Asalah Sayed on 02/05/2023.
//

import UIKit

class FootballTableViewCell: UITableViewCell {
    @IBOutlet weak var footballView: UIView!
    
    @IBOutlet weak var footballImage: UIImageView!
    
    @IBOutlet weak var footballTitle: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
