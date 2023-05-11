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
    override func viewWillAppear(_ animated: Bool) {
        self.title = team?.team_name
        
        let teamDetailsViewModel = TeamDetailsViewModel()
        if teamDetailsViewModel.isExist(favouriteId: (team?.team_key)!){
            btn.isEnabled = false
        }
        else {
            btn.isEnabled = true
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        if flag == true {
            btn.isHidden = true
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
        if teamDetailsViewModel.isExist(favouriteId: (team?.team_key)!){
            btn.isEnabled = false
        }else{
            let alert = UIAlertController(title: "Alert!", message: "Do you want to save \(self.team?.team_name ?? "")",preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Yes",style: .default,handler: {(_: UIAlertAction!) in
                teamDetailsViewModel.insertTeam(favouriteName: (self.team?.team_name)!, favouriteId: (self.team?.team_key)!, sportType: self.sportType!)
                self.btn.isEnabled = false
                
            }))
            alert.addAction(UIAlertAction(title: "No",style: .default,handler: {(_: UIAlertAction!) in
                alert.dismiss(animated: true)
            }))
            self.present(alert, animated: true, completion: nil)
            
            
        }

    }
}
