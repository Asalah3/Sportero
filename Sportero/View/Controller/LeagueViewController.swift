//
//  LeagueViewController.swift
//  Sportero
//
//  Created by Asalah Sayed on 03/05/2023.
//

import UIKit

class LeagueViewController: UIViewController , UITableViewDelegate , UITableViewDataSource{
    @IBOutlet weak var tableView: UITableView!
    var leaguesViewModel : LeaguesViewModel!
    var sport : String?
    var leagues : Leagues?
//    let network = NetworkServices()
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.separatorStyle = .none
        leaguesViewModel = LeaguesViewModel()
        leaguesViewModel.getLeaguesResult(sportType: sport!)
        leaguesViewModel.bindResultToLeagueViewController = {() in
            DispatchQueue.main.async {
                self.leagues  = self.leaguesViewModel.leaguesResult
                self.tableView.reloadData()
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
