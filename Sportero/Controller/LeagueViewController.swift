//
//  LeagueViewController.swift
//  Sportero
//
//  Created by Asalah Sayed on 03/05/2023.
//

import UIKit

class LeagueViewController: UIViewController , UITableViewDelegate , UITableViewDataSource{
    var leagues : Leagues?
    let network = NetworkServices()
    @IBOutlet weak var tableView: UITableView!
    var sport : String?
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.separatorStyle = .none
        network.fetchLeaguesResult(sport: sport!){[weak self](result) in
                DispatchQueue.main.async {
                    self?.leagues  = result
                    self?.tableView.reloadData()
                }
        }
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return leagues?.result.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? FootballTableViewCell
        cell?.footballView.layer.cornerRadius = 25
        cell?.footballImage.layer.cornerRadius = 25
        cell?.footballTitle.text = leagues?.result[indexPath.row].leagueName
        var image = leagues?.result[indexPath.row].leagueLogo
        if image == nil{
            image = ""
        }
        cell?.footballImage.sd_setImage(with: URL(string:image!), placeholderImage: UIImage(named: sport!))
        return cell!
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let leagueId = leagues?.result[indexPath.row].leagueKey
        let leagueDetailsViewController = self.storyboard?.instantiateViewController(withIdentifier: "LeagueDetailsViewController") as! LeagueDetailsViewController
        leagueDetailsViewController.sport = sport
        leagueDetailsViewController.leagueId = leagueId ?? 0
        
        navigationController?.pushViewController(leagueDetailsViewController, animated: true)
    }

    
}
