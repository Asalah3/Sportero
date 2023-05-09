//
//  SportsViewController.swift
//  Sportero
//
//  Created by Asalah Sayed on 01/05/2023.
//

import UIKit
import Reachability

let reachability = try! Reachability()
class SportsViewController: UIViewController {
    @IBOutlet weak var switchMode: UISwitch!
    @IBOutlet weak var collectionView: UICollectionView!
    var sportsImages : [String] = ["football","basketball" , "tennis" , "cricket"]
    var sportsNames : [String] = ["Football","Basketball" , "Tennis" , "Cricket"]
    let network = NetworkServices()
    override func viewDidLoad() {
        super.viewDidLoad()
        if UserDefaults.standard.darkMode{
            switchMode.setOn(true, animated: true)
        }
        else{
            switchMode.setOn(false, animated: true)
        }
        collectionView.collectionViewLayout = UICollectionViewFlowLayout()

    }
    

    @IBAction func onClickSwitch(_ sender: Any) {
        if #available(iOS 13.0, *){
            let appDelegate = UIApplication.shared.windows.first
            if (sender as AnyObject).isOn {
                appDelegate?.overrideUserInterfaceStyle = .dark
                UserDefaults.standard.darkMode = true

                return
            }else {
                appDelegate?.overrideUserInterfaceStyle = .light
                UserDefaults.standard.darkMode = false
                return
            }
        }
    }
}


extension SportsViewController : UICollectionViewDelegate , UICollectionViewDataSource ,UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? SportsCollectionViewCell
        cell?.layer.borderWidth = 1
        cell?.layer.cornerRadius = 25
        cell?.layer.borderColor = UIColor.orange.cgColor
        cell?.sportName.text = sportsNames[indexPath.row]
        cell?.sportImage.image = UIImage(named: sportsImages[indexPath.row])!
        return cell!
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return sportsNames.count
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = (collectionView.frame.size.width-10)/2
        return CGSize(width: size, height: size)
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
       // reachability.whenReachable = { _ in
            if indexPath.row == 0{
                let leagueViewController = self.storyboard?.instantiateViewController(withIdentifier: "LeagueViewController") as! LeagueViewController
                print(self.sportsNames[indexPath.row])
                leagueViewController.sport = "football"
                self.navigationController?.pushViewController(leagueViewController, animated: true)
            }else if indexPath.row == 1{
                print(self.sportsNames[indexPath.row])
                let leagueViewController = self.storyboard?.instantiateViewController(withIdentifier: "LeagueViewController") as! LeagueViewController
                leagueViewController.sport = "basketball"
                self.navigationController?.pushViewController(leagueViewController, animated: true)
            }else if indexPath.row == 2{
                let leagueViewController = self.storyboard?.instantiateViewController(withIdentifier: "LeagueViewController") as! LeagueViewController
                print(self.sportsNames[indexPath.row])
                leagueViewController.sport = "tennis"
                self.navigationController?.pushViewController(leagueViewController, animated: true)

            }else if indexPath.row == 3{
                let leagueViewController = self.storyboard?.instantiateViewController(withIdentifier: "LeagueViewController") as! LeagueViewController
                print(self.sportsNames[indexPath.row])
                leagueViewController.sport = "cricket"
                self.navigationController?.pushViewController(leagueViewController, animated: true)

            }
            
                
           // }
        /*reachability.whenUnreachable = { _ in
            let alert = UIAlertController(title: "Warrning!", message: "There is no Internet Connection",preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok",style: .default,handler: {(_: UIAlertAction!) in
                alert.dismiss(animated: true)
            }))
            self.present(alert, animated: true, completion: nil)
        }
        do{
            try reachability.startNotifier()
        }catch{
            print("Unable to start Notifier")
        }*/
        
    }
}
