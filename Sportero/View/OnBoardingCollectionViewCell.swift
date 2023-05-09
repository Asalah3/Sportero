//
//  OnBoardingCollectionViewCell.swift
//  Sportero
//
//  Created by Asalah Sayed on 09/05/2023.
//

import UIKit

class OnBoardingCollectionViewCell: UICollectionViewCell {
    static let identifier = String(describing: OnBoardingCollectionViewCell.self)
    
    @IBOutlet weak var slideImage: UIImageView!
    
    @IBOutlet weak var slideLabel: UILabel!
    func setUp(_ slide : OnBoardingSlide) {
        slideImage.image = slide.image
        slideLabel.text = slide.description
    }
}
