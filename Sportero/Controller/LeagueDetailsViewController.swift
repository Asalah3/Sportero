//
//  UpComingEventsViewController.swift
//  Sportero
//
//  Created by Asalah Sayed on 04/05/2023.
//

import UIKit
import SDWebImage
class LeagueDetailsViewController: UIViewController ,UICollectionViewDelegate , UICollectionViewDelegateFlowLayout , UICollectionViewDataSource {
    
    var network = NetworkServices()
    var upComingEvents : Fixtures?
    var latestResults : Livescore?
    var cricketLatestResults : CricketLivescore?
    var teams : Teams?
    var tennisTeams : [Int] = []
    var leagueId : Int?
    var sport : String?
    @IBOutlet weak var UpComingCollectionView: UICollectionView!
    @IBOutlet weak var latestResultCollectionView: UICollectionView!
    @IBOutlet weak var teamsCollectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        self.UpComingCollectionView.collectionViewLayout = layout
        
        let layout2 = UICollectionViewFlowLayout()
        layout2.scrollDirection = .horizontal
        self.teamsCollectionView.collectionViewLayout = layout2
        
        let layout3 = UICollectionViewFlowLayout()
        layout3.scrollDirection = .vertical
        self.latestResultCollectionView.collectionViewLayout = layout3
        
            network.fetchFixturesResult(sport: sport!, leagueId: leagueId!){[weak self](result) in
                DispatchQueue.main.async {
                    self?.upComingEvents  = result
                    result?.result?.forEach { element in
                        if self?.sport == "tennis"{
                            self!.tennisTeams.append(element.first_player_key!)
                            self!.tennisTeams.append(element.second_player_key!)
                            self?.teamsCollectionView.reloadData()
                        }
                    }
                    self?.UpComingCollectionView.reloadData()
                }
            }
        if sport == "cricket"{
            network.fetchCricketLivescoreResult(leagueId: leagueId!){[weak self](result) in
                DispatchQueue.main.async {
                    self?.cricketLatestResults  = result
                    self?.latestResultCollectionView.reloadData()
                }
            }
        }else{
            network.fetchLiveScoreResult(sport: sport!, leagueId: leagueId!){[weak self](result) in
                DispatchQueue.main.async {
                    self?.latestResults  = result
                    self?.latestResultCollectionView.reloadData()
                }
            }
        }
           
            network.fetchTeamsResult(sport: sport!, leagueId: leagueId!){[weak self](result) in
                DispatchQueue.main.async {
                    self?.teams = result
                    self?.teamsCollectionView.reloadData()
                }
            }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == UpComingCollectionView{
            return upComingEvents?.result?.count ?? 0
        }else if collectionView == latestResultCollectionView{
            if sport == "cricket"{
                return cricketLatestResults?.result.count ?? 0
            }
            return latestResults?.result?.count ?? 0
        }
        if sport == "tennis" {
            print("count \(tennisTeams.count)")
            return tennisTeams.count
        }
        return teams?.result.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == UpComingCollectionView{
            let cell = UpComingCollectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? UpComingEventsCollectionViewCell
            cell?.layer.borderWidth = 1
            cell?.layer.cornerRadius = 25
            cell?.layer.borderColor = UIColor.blue.cgColor
            
            if sport == "tennis"{
                var image1 = upComingEvents?.result?[indexPath.row].event_first_player_logo
                if image1 == nil{
                    image1 = ""
                }
                cell?.teamOneImage.sd_setImage(with: URL(string:image1!), placeholderImage: UIImage(named: "player"))
                cell?.teamOneLabel.text = upComingEvents?.result?[indexPath.row].event_first_player
                
                var image2 = upComingEvents?.result?[indexPath.row].event_second_player_logo
                if image2 == nil{
                    image2 = ""
                }
                cell?.teamTwoImage.sd_setImage(with: URL(string:image2!), placeholderImage: UIImage(named: "player"))
                cell?.teamTwoLabel.text = upComingEvents?.result?[indexPath.row].event_second_player
                
                cell?.date.text = upComingEvents?.result?[indexPath.row].event_date
                cell?.time.text = upComingEvents?.result?[indexPath.row].event_time
                return cell!
            }
//============================================================================================================================================
            else if sport == "cricket" || sport == "basketball"{
                
                var image1 = upComingEvents?.result?[indexPath.row].event_home_team_logo
                if image1 == nil{
                    image1 = ""
                }
                cell?.teamOneImage.sd_setImage(with: URL(string:image1!), placeholderImage: UIImage(named: "ball_\(sport ?? "")"))
                cell?.teamOneLabel.text = upComingEvents?.result?[indexPath.row].event_home_team
                
                var image2 = upComingEvents?.result?[indexPath.row].event_away_team_logo
                if image2 == nil{
                    image2 = ""
                }
                cell?.teamTwoImage.sd_setImage(with: URL(string:image2!), placeholderImage: UIImage(named: "ball_\(sport ?? "")"))
                cell?.teamTwoLabel.text = upComingEvents?.result?[indexPath.row].event_away_team
                if sport == "basketball"{
                    cell?.date.text = upComingEvents?.result?[indexPath.row].event_date_start
                }else{
                    cell?.date.text = upComingEvents?.result?[indexPath.row].event_date
                }
                cell?.time.text = upComingEvents?.result?[indexPath.row].event_time
                return cell!
                
            }
//============================================================================================================================================
            else{
                
                var image1 = upComingEvents?.result?[indexPath.row].home_team_logo
                if image1 == nil{
                    image1 = ""
                }
                cell?.teamOneImage.sd_setImage(with: URL(string:image1!), placeholderImage: UIImage(named: "ball_\(sport ?? "")"))
                cell?.teamOneLabel.text = upComingEvents?.result?[indexPath.row].event_home_team
                
                var image2 = upComingEvents?.result?[indexPath.row].away_team_logo
                if image2 == nil{
                    image2 = ""
                }
                cell?.teamTwoImage.sd_setImage(with: URL(string:image2!), placeholderImage: UIImage(named: "ball_\(sport ?? "")"))
                cell?.teamTwoLabel.text = upComingEvents?.result?[indexPath.row].event_away_team
                
                cell?.date.text = upComingEvents?.result?[indexPath.row].event_date
                cell?.time.text = upComingEvents?.result?[indexPath.row].event_time
                return cell!
                
            }
            
            
//*******************************************************************************************************************************************************************
            
        }else if collectionView == latestResultCollectionView{
            let cell = latestResultCollectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? LatestResultCollectionViewCell
            cell?.layer.borderWidth = 1
            cell?.layer.cornerRadius = 25
            cell?.layer.borderColor = UIColor.blue.cgColor
            
            if sport == "tennis"{
                
                cell?.teamOneImage.image =  UIImage(named: "player")
                cell?.teamOneLabel.text = latestResults?.result?[indexPath.row].event_first_player
                
                cell?.teamTwoImage.image =  UIImage(named: "player")
                cell?.teamTwoLabel.text = latestResults?.result?[indexPath.row].event_second_player
                
                cell?.dateLabel.text = latestResults?.result?[indexPath.row].event_date
                cell?.timeLabel.text = latestResults?.result?[indexPath.row].event_time
                cell?.scoreLabel.text = latestResults?.result?[indexPath.row].event_final_result
                
                return cell!
            }
//============================================================================================================================================
            
            else if sport == "cricket"{
                var image1 = cricketLatestResults?.result[indexPath.row].eventHomeTeamLogo
                if image1 == nil{
                    image1 = ""
                }
                cell?.teamOneImage.sd_setImage(with: URL(string:image1!), placeholderImage: UIImage(named: "ball_\(sport ?? "")"))
                cell?.teamOneLabel.text = cricketLatestResults?.result[indexPath.row].eventHomeTeam
                
                var image2 = cricketLatestResults?.result[indexPath.row].eventAwayTeamLogo
                if image2 == nil{
                    image2 = ""
                }
                cell?.teamTwoImage.sd_setImage(with: URL(string:image2!), placeholderImage: UIImage(named: "ball_\(sport ?? "")"))
                cell?.teamTwoLabel.text = cricketLatestResults?.result[indexPath.row].eventAwayTeam
                
                cell?.dateLabel.text = cricketLatestResults?.result[indexPath.row].eventDateStart
                cell?.timeLabel.text = cricketLatestResults?.result[indexPath.row].eventTime
                cell?.scoreLabel.text = "\(cricketLatestResults?.result[indexPath.row].eventHomeFinalResult ?? "") - \(cricketLatestResults?.result[indexPath.row].eventAwayFinalResult ?? "")"
                
                return cell!
            }
            
//============================================================================================================================================

            else{
                var image1 = latestResults?.result?[indexPath.row].home_team_logo
                if image1 == nil{
                    image1 = ""
                }
                cell?.teamOneImage.sd_setImage(with: URL(string:image1!), placeholderImage: UIImage(named: "ball_\(sport ?? "")"))
                cell?.teamOneLabel.text = latestResults?.result?[indexPath.row].event_home_team
                
                var image2 = latestResults?.result?[indexPath.row].away_team_logo
                if image2 == nil{
                    image2 = ""
                }
                cell?.teamTwoImage.sd_setImage(with: URL(string:image2!), placeholderImage: UIImage(named: "ball_\(sport ?? "")"))
                cell?.teamTwoLabel.text = latestResults?.result?[indexPath.row].event_away_team
                
                cell?.dateLabel.text = latestResults?.result?[indexPath.row].event_date
                cell?.timeLabel.text = latestResults?.result?[indexPath.row].event_time
                cell?.scoreLabel.text = latestResults?.result?[indexPath.row].event_final_result
                
                return cell!
            }
            
        }
        
        //*******************************************************************************************************************************************************************************

        
        let cell2 = teamsCollectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? TeamsCollectionViewCell
        cell2?.layer.borderWidth = 1
        cell2?.layer.cornerRadius = (cell2?.frame.height)!/2
        cell2?.layer.borderColor = UIColor.blue.cgColor
        if sport == "cricket" {
            var image1 = teams?.result[indexPath.row].team_logo
            if image1 == nil{
                image1 = ""
            }
            cell2?.teamImage.sd_setImage(with: URL(string:image1!), placeholderImage: UIImage(named: "ball_\(sport ?? "")"))
            return cell2!
        }else if sport == "tennis"{
            cell2?.teamImage.image = UIImage(named: "player")
            print("\(tennisTeams[indexPath.row])")
            return cell2!
        }else{
            var image1 = teams?.result[indexPath.row].team_logo
            if image1 == nil{
                image1 = ""
            }
            cell2?.teamImage.sd_setImage(with: URL(string:image1!), placeholderImage: UIImage(named: "ball_\(sport ?? "")"))
            return cell2!
        }
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == UpComingCollectionView{
            let size = (UpComingCollectionView.frame.size.width-10)
            return CGSize(width: size, height: size/2.25)
        }else if collectionView == latestResultCollectionView{
            let size = (latestResultCollectionView.frame.size.width)
            return CGSize(width: size, height: (size-10)/2.25)
        }
        let size2 = (teamsCollectionView.frame.size.width)/4
        return CGSize(width: size2-10, height: size2-10)
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == teamsCollectionView {
            if sport == "cricket" || sport == "basketball" {
                let alert = UIAlertController(title: "Warrning!", message: "There is no data to display",preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Ok",style: .default,handler: {(_: UIAlertAction!) in
                    alert.dismiss(animated: true)
                }))
                self.present(alert, animated: true, completion: nil)
            }else if sport == "tennis" {
                let tennisPlayerDetailsViewController = self.storyboard?.instantiateViewController(withIdentifier: "TennisPlayerDetailsViewController") as! TennisPlayerDetailsViewController
                tennisPlayerDetailsViewController.playerId = tennisTeams[indexPath.row]
                navigationController?.pushViewController(tennisPlayerDetailsViewController, animated: true)
            }else{
                let team = teams?.result[indexPath.row]
                let teamDetailsViewController = self.storyboard?.instantiateViewController(withIdentifier: "TeamDetailsViewController") as! TeamDetailsViewController
                teamDetailsViewController.team = team
                teamDetailsViewController.sportType = sport!
                navigationController?.pushViewController(teamDetailsViewController, animated: true)
            }
            
        }
    }
}
