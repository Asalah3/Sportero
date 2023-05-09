//
//  TennisPlayerDetailsViewController.swift
//  Sportero
//
//  Created by Asalah Sayed on 06/05/2023.
//

import UIKit
import SDWebImage
import CoreData
class TennisPlayerDetailsViewController: UIViewController {

    @IBOutlet weak var playerName: UILabel!
    @IBOutlet weak var playerCountry: UILabel!
    @IBOutlet weak var playerImage: UIImageView!
    @IBOutlet weak var playerBD: UILabel!
    @IBOutlet weak var btn: UIButton!
    var tennisPlayerDetailsViewModel : TennisPlayerDetailsViewModel!
    var playerId = 0
    var network = NetworkServices()
    var player : TennisPlayer?
    var flag : Bool?
    override func viewDidLoad() {
        super.viewDidLoad()
        playerName.layer.cornerRadius = 25
        playerName.layer.borderWidth = 1
        playerName.layer.borderColor = UIColor.orange.cgColor
        if flag == true {
            btn.setImage(UIImage(systemName: "heart.fill"), for: .normal)
        }
        tennisPlayerDetailsViewModel = TennisPlayerDetailsViewModel()
        tennisPlayerDetailsViewModel.getTennisPlayerResult(playerId: playerId)
        tennisPlayerDetailsViewModel.bindResultToTennisPlayerDetailsViewController  = { [weak self]() in
            DispatchQueue.main.async {
                self?.player  = self?.tennisPlayerDetailsViewModel.playerResult
                self?.playerName.text = self?.player?.result[0].playerName
                self?.playerCountry.text = self?.player?.result[0].playerCountry ?? "There is no data"
                self?.playerBD.text = self?.player?.result[0].playerBday ?? "There is no data"
                var image1 = self?.player?.result[0].playerLogo
                if image1 == nil{
                    image1 = ""
                }
                self?.playerImage.sd_setImage(with: URL(string:image1!), placeholderImage: UIImage(named: "player"))
            }
        }
    }
    
    @IBAction func addPlayerToFavourite(_ sender: Any) {
//        FavouriteItems.favouriteItems.InsertItem(favouriteName: (player?.result[0].playerName)!, favouriteId: (player?.result[0].playerKey)!, sportType: "tennis")
        tennisPlayerDetailsViewModel.insertPlayer(favouriteName: (player?.result[0].playerName)!, favouriteId: (player?.result[0].playerKey)!, sportType: "tennis")
        btn.setImage(UIImage(systemName: "heart.fill"), for: .normal)

    }
}
