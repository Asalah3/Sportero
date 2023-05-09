//
//  FavouriteViewController.swift
//  Sportero
//
//  Created by Asalah Sayed on 01/05/2023.
//

import UIKit
import CoreData

class FavouriteViewController: UIViewController , UITableViewDelegate , UITableViewDataSource{
    @IBOutlet weak var tableView: UITableView!
    var favouriteViewModel : FavouriteViewModel!
    var favouritesList : [NSManagedObject]?
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.separatorStyle = .none
        favouriteViewModel = FavouriteViewModel()
        favouriteViewModel.getFavouritesResult()
        favouritesList = favouriteViewModel.Result
        self.tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favouritesList?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? FavouriteTableViewCell
        cell?.favouriteView.layer.cornerRadius = 25
        cell?.favouriteView.layer.borderWidth = 1
        cell?.favouriteView.layer.borderColor = UIColor.orange.cgColor
        let favouriteItem = favouritesList?[indexPath.row]
        let favouriteName = favouriteItem?.value(forKey: "favouriteName") as! String
        let favouriteSport = favouriteItem?.value(forKey: "sportType") as! String
        cell?.nameLabel.text = favouriteName
        cell?.sportLabel.text = favouriteSport
        return cell!
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        let favouriteItem = favouritesList?[indexPath.row]
        let favouriteName = favouriteItem?.value(forKey: "favouriteName") as! String
        
        if editingStyle == .delete {
            let alert : UIAlertController = UIAlertController(title: "Warnning", message: "Do You Want To Delete \(favouriteName)", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Delete", style: .destructive , handler: { action in
                self.favouriteViewModel.deleteFavouriteItem(favouriteItem: favouriteItem!)
                self.favouriteViewModel.getFavouritesResult()
                self.favouritesList?.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .fade)
            }))
            alert.addAction(UIAlertAction(title: "Cancel", style: .default , handler: nil))
            
            self.present(alert, animated: true)
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let favouriteItem = favouritesList?[indexPath.row]
        let favouriteId = favouriteItem?.value(forKey: "favouriteId") as! Int
        let favouriteSport = favouriteItem?.value(forKey: "sportType") as! String
        if favouriteSport == "tennis"{
            let tennisPlayerDetailsViewController = self.storyboard?.instantiateViewController(withIdentifier: "TennisPlayerDetailsViewController") as! TennisPlayerDetailsViewController
            tennisPlayerDetailsViewController.playerId = favouriteId
            tennisPlayerDetailsViewController.flag = true
            navigationController?.pushViewController(tennisPlayerDetailsViewController, animated: true)
        }else{
            let teamDetailsViewController = self.storyboard?.instantiateViewController(withIdentifier: "TeamDetailsViewController") as! TeamDetailsViewController
            favouriteViewModel.getTeamResult(sportType: favouriteSport, teamId: favouriteId)
            favouriteViewModel.bindResultToFavouriteViewController = {[weak self]() in
                DispatchQueue.main.async {
                    let team = self?.favouriteViewModel.teamResult.result[0]
                    teamDetailsViewController.team = team
                    teamDetailsViewController.sportType = favouriteSport
                    teamDetailsViewController.flag = true
                    self?.navigationController?.pushViewController(teamDetailsViewController, animated: true)
                }
            }
        }
        
    }

}
