//
//  TeamDetailsViewController.swift
//  Sportero
//
//  Created by Asalah Sayed on 05/05/2023.
//

import UIKit

class TeamDetailsViewController: UIViewController ,UITableViewDelegate , UITableViewDataSource{
    @IBOutlet weak var TeamName: UILabel!
    @IBOutlet weak var TeamLogo: UIImageView!
    @IBOutlet weak var playersTableView: UITableView!
    @IBOutlet weak var btn: UIButton!
    var sportType : String?
    let network = NetworkServices()
    var team : TeamsResult?
    var flag : Bool?
    override func viewDidLoad() {
        super.viewDidLoad()
        if flag == true {
            btn.setImage(UIImage(systemName: "heart.fill"), for: .normal)
        }
        playersTableView.separatorStyle = .none
        TeamName.layer.cornerRadius = 25
        TeamName.layer.borderWidth = 1
        TeamName.layer.borderColor = UIColor.orange.cgColor
        var image = team?.team_logo
        if image == nil{
            image = ""
        }
        TeamLogo.sd_setImage(with: URL(string:image!), placeholderImage: UIImage(named: (sportType!)))
        TeamName.text = team?.team_name!
        playersTableView.reloadData()
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return team?.players?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = playersTableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? PlayerTableViewCell
        cell?.playerName.text = team?.players?[indexPath.row].player_name!
        cell?.playerNumber.text = team?.players?[indexPath.row].player_number!
        var image = team?.players?[indexPath.row].player_image
        if image == nil{
            image = ""
        }
        cell?.playerImage.sd_setImage(with: URL(string:image!), placeholderImage: UIImage(named: "player"))
        return cell!
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }

    @IBAction func addToFavourites(_ sender: Any) {
        let teamDetailsViewModel = TeamDetailsViewModel()
        teamDetailsViewModel.insertTeam(favouriteName: (team?.team_name)!, favouriteId: (team?.team_key)!, sportType: sportType!)
//        FavouriteItems.favouriteItems.InsertItem(favouriteName: (team?.team_name)!, favouriteId: (team?.team_key)!, sportType: sportType!)
        btn.setImage(UIImage(systemName: "heart.fill"), for: .normal)

    }
}
