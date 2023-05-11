//
//  LeagueViewController.swift
//  Sportero
//
//  Created by Asalah Sayed on 03/05/2023.
//

import UIKit
import SDWebImage

class LeagueViewController: UIViewController , UITableViewDelegate , UITableViewDataSource{
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    var leaguesViewModel : LeaguesViewModel!
    var sport : String?
    var leagues : Leagues?
    var leaguesResult = [Result]()
    var searching = false
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = sport!
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
        if searching{
            return leaguesResult.count
        }else{
            return leagues?.result.count ?? 0
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? FootballTableViewCell
        cell?.footballView.layer.cornerRadius = 25
        cell?.footballImage.layer.cornerRadius = 25
        cell?.footballView.layer.borderWidth = 1
        cell?.footballView.layer.borderColor = UIColor.orange.cgColor
        if searching {
            cell?.footballTitle.text = leaguesResult[indexPath.row].leagueName
            var image = leaguesResult[indexPath.row].leagueLogo
            if image == nil{
                image = ""
            }
            cell?.footballImage.sd_imageIndicator = SDWebImageActivityIndicator.gray
            cell?.footballImage.sd_setImage(with: URL(string:image!), placeholderImage: UIImage(named: sport!))
            return cell!
        }else{
            cell?.footballTitle.text = leagues?.result[indexPath.row].leagueName
            var image = leagues?.result[indexPath.row].leagueLogo
            if image == nil{
                image = ""
            }
            cell?.footballImage.sd_imageIndicator = SDWebImageActivityIndicator.gray
            cell?.footballImage.sd_setImage(with: URL(string:image!), placeholderImage: UIImage(named: sport!))
            return cell!
        }
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var leagueId = 0
        var leagueName = ""
        if searching {
            leagueId = leaguesResult[indexPath.row].leagueKey
            leagueName = leaguesResult[indexPath.row].leagueName
        }else{
            leagueId = (leagues?.result[indexPath.row].leagueKey)!
            leagueName = (leagues?.result[indexPath.row].leagueName)!
        }
        
        if InternetConnection().isConnectedToNetwork() == true{
            let leagueDetailsViewController = self.storyboard?.instantiateViewController(withIdentifier: "LeagueDetailsViewController") as! LeagueDetailsViewController
            leagueDetailsViewController.sport = sport
            leagueDetailsViewController.leagueId = leagueId
            leagueDetailsViewController.leagueName = leagueName
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
extension LeagueViewController : UISearchBarDelegate{
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        leaguesResult = (leagues?.result.filter({$0.leagueName.lowercased().prefix(searchText.count) == searchText.lowercased()}))!
        searching = true
        tableView.reloadData()
    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searching = false
        searchBar.text = ""
        tableView.reloadData()
    }
}
