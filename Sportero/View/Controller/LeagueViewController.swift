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
        cell?.footballView.layer.borderWidth = 1
        cell?.footballView.layer.borderColor = UIColor.orange.cgColor
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
        if InternetConnection().isConnectedToNetwork() == true{
            let leagueDetailsViewController = self.storyboard?.instantiateViewController(withIdentifier: "LeagueDetailsViewController") as! LeagueDetailsViewController
            leagueDetailsViewController.sport = sport
            leagueDetailsViewController.leagueId = leagueId ?? 0
            
            navigationController?.pushViewController(leagueDetailsViewController, animated: true)
        }else{
            let alert = UIAlertController(title: "Warrning!", message: "There is no Internet Connection",preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok",style: .default,handler: {(_: UIAlertAction!) in
                alert.dismiss(animated: true)
            }))
            self.present(alert, animated: true, completion: nil)
        }
    }

    
}
