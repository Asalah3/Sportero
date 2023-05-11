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
    override func viewWillAppear(_ animated: Bool) {
        let tennisPlayerDetailsViewModel = TennisPlayerDetailsViewModel()
        if tennisPlayerDetailsViewModel.isExist(favouriteId: playerId){
            btn.setImage(UIImage(systemName: "heart.fill"), for: .normal)
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        playerName.layer.cornerRadius = 25
        playerName.layer.borderWidth = 1
        playerName.layer.borderColor = UIColor.orange.cgColor
        if flag == true {
            
        }
        tennisPlayerDetailsViewModel = TennisPlayerDetailsViewModel()
        tennisPlayerDetailsViewModel.getTennisPlayerResult(playerId: playerId)
        tennisPlayerDetailsViewModel.bindResultToTennisPlayerDetailsViewController  = { [weak self]() in
            DispatchQueue.main.async {
                self?.player  = self?.tennisPlayerDetailsViewModel.playerResult
                self?.playerName.text = self?.player?.result[0].playerName
                self!.title = self?.player?.result[0].playerName

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
        
        if tennisPlayerDetailsViewModel.isExist(favouriteId: playerId){
            let alert = UIAlertController(title: "Alert!", message: "Do you want to delete \((self.player?.result[0].playerName)!) ",preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Delete",style: .destructive,handler: {(_: UIAlertAction!) in
                self.tennisPlayerDetailsViewModel.deleteItemById(favouriteId: (self.player?.result[0].playerKey)!)
                self.btn.setImage(UIImage(systemName: "heart"), for: .normal)
            }))
            alert.addAction(UIAlertAction(title: "No",style: .cancel,handler: {(_: UIAlertAction!) in
                alert.dismiss(animated: true)
            }))
            self.present(alert, animated: true, completion: nil)
        }
        else {
            let alert = UIAlertController(title: "Saving!", message: "Do you want to save this \(self.player?.result[0].playerName ?? "")",preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Yes",style: .default,handler: {(_: UIAlertAction!) in
                self.tennisPlayerDetailsViewModel.insertPlayer(favouriteName: (self.player?.result[0].playerName)!, favouriteId: (self.player?.result[0].playerKey)!, sportType: "tennis")
                self.btn.setImage(UIImage(systemName: "heart.fill"), for: .normal)
                
            }))
            alert.addAction(UIAlertAction(title: "No",style: .cancel,handler: {(_: UIAlertAction!) in
                alert.dismiss(animated: true)
            }))
            self.present(alert, animated: true, completion: nil)
            
        }

    }
}
