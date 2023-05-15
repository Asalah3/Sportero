//
//  PlayerViewController.swift
//  Sportero
//
//  Created by Asalah Sayed on 15/05/2023.
//

import UIKit

class PlayerViewController: UIViewController {

    @IBOutlet weak var playerImage: UIImageView!
    @IBOutlet weak var playerName: UILabel!
    @IBOutlet weak var playerType: UILabel!
    @IBOutlet weak var playerAge: UILabel!
    @IBOutlet weak var playerNumber: UILabel!
    var activiyIndicator  = UIActivityIndicatorView()
    var footballPlayerViewModel : FootballPlayerViewModel!
    var playerId = 0
    var playerNum = 0
    var player : FootballPlayer?
    override func viewDidLoad() {
        super.viewDidLoad()
        activiyIndicator.center = self.view.center
        activiyIndicator.hidesWhenStopped = true
        activiyIndicator.style = .large
        activiyIndicator.color = UIColor.orange
        view.addSubview(activiyIndicator)
        activiyIndicator.startAnimating()
        self.view.isUserInteractionEnabled = false
        footballPlayerViewModel = FootballPlayerViewModel()
        footballPlayerViewModel.getFootballPlayerResult(playerId: playerId)
        footballPlayerViewModel.bindResultToFootballPlayerViewController  = { [weak self]() in
            DispatchQueue.main.async {
                self?.player  = self?.footballPlayerViewModel.playerResult
                self?.activiyIndicator.stopAnimating()
                self?.view.isUserInteractionEnabled = true
                self?.playerName.text = self?.player?.result[0].playerName
                self?.playerAge.text = self?.player?.result[0].playerAge ?? "There is no data"
                if self?.player?.result[0].playerNumber == "" || self?.player?.result[0].playerNumber == nil{
                    self?.playerNumber.text = String(self?.playerNum ?? 0)
                }else{
                    self?.playerNumber.text = self?.player?.result[0].playerNumber ?? "There is no data"
                }
                self?.playerType.text = self?.player?.result[0].playerType ?? "There is no data"
                var image1 = self?.player?.result[0].playerImage
                if image1 == nil{
                    image1 = ""
                }
                self?.playerImage.sd_setImage(with: URL(string:image1!), placeholderImage: UIImage(named: "player"))
            }
        }
    }


}
