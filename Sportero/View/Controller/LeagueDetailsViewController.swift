//
//  UpComingEventsViewController.swift
//  Sportero
//
//  Created by Asalah Sayed on 04/05/2023.
//

import UIKit
import SDWebImage
import Lottie
class LeagueDetailsViewController: UIViewController ,UICollectionViewDelegate , UICollectionViewDelegateFlowLayout , UICollectionViewDataSource {
    var leagueDetailsViewModel :LeaguesDetailsViewModel!
    var network = NetworkServices()
    var upComingEvents : Fixtures?
    var latestResults : Livescore?
    var cricketLatestResults : CricketLivescore?
    var teams : Teams?
    var tennisTeams : [Int] = []
    var leagueId : Int?
    var sport : String?
    var leagueName : String?
    var fixtureActiviyIndicator  = UIActivityIndicatorView()
    @IBOutlet weak var noData: AnimationView!
    @IBOutlet weak var noDataLatest: AnimationView!
    @IBOutlet weak var noDataTeams: AnimationView!
    @IBOutlet weak var UpComingCollectionView: UICollectionView!
    @IBOutlet weak var latestResultCollectionView: UICollectionView!
    @IBOutlet weak var teamsCollectionView: UICollectionView!
    override func viewWillAppear(_ animated: Bool) {
        UpComingCollectionView.reloadData()
        latestResultCollectionView.reloadData()
        teamsCollectionView.reloadData()
        noDataTeams.isHidden = true
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        fixtureActiviyIndicator.center = self.view.center
        fixtureActiviyIndicator.hidesWhenStopped = true
        fixtureActiviyIndicator.style = .large
        fixtureActiviyIndicator.color = UIColor.orange
        view.addSubview(fixtureActiviyIndicator)
        fixtureActiviyIndicator.startAnimating()
        self.view.isUserInteractionEnabled = false
        self.title = leagueName
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        self.UpComingCollectionView.collectionViewLayout = layout
        
        let layout2 = UICollectionViewFlowLayout()
        layout2.scrollDirection = .horizontal
        self.teamsCollectionView.collectionViewLayout = layout2
        
        let layout3 = UICollectionViewFlowLayout()
        layout3.scrollDirection = .vertical
        self.latestResultCollectionView.collectionViewLayout = layout3
        leagueDetailsViewModel = LeaguesDetailsViewModel()
        leagueDetailsViewModel.getUpComingEvents(sportType: sport!, leagueId: leagueId!)
        leagueDetailsViewModel.bindUpComingEventsToLeagueDetailsViewController = {() in
            DispatchQueue.main.async {
                self.upComingEvents = self.leagueDetailsViewModel.upComingEvents
                if self.upComingEvents?.result?.count == nil{
                    self.UpComingCollectionView.isHidden = true
                    self.noData.isHidden = false
                    self.noData.contentMode = .scaleAspectFit
                    self.noData.loopMode = .loop
                    self.noData.play()

                }
                self.upComingEvents?.result?.forEach { element in
                    if self.sport == "tennis"{
                        self.tennisTeams.append(element.first_player_key!)
                        self.tennisTeams.append(element.second_player_key!)
                        self.teamsCollectionView.reloadData()
                    }
                }
                if self.sport == "tennis"{
                    if self.tennisTeams.count == 0{
                        self.teamsCollectionView.isHidden = true
                        self.noDataTeams.isHidden = false
                        self.noDataTeams.contentMode = .scaleAspectFit
                        self.noDataTeams.loopMode = .loop
                        self.noDataTeams.play()
                    }
                    
                }
                self.fixtureActiviyIndicator.stopAnimating()
                self.view.isUserInteractionEnabled = true
                self.UpComingCollectionView.reloadData()
                
            }
        }
        if sport == "cricket"{
            leagueDetailsViewModel.getCricketLatestResult(leagueId: leagueId!)
            leagueDetailsViewModel.bindCricketLatestResultsToLeagueDetailsViewController = {() in
                DispatchQueue.main.async {
                    if self.leagueDetailsViewModel.cricketLatestResults == nil {
                        self.latestResultCollectionView.isHidden = true
                        self.noDataLatest.isHidden = false
                        self.noDataLatest.contentMode = .scaleAspectFit
                        self.noDataLatest.loopMode = .loop
                        self.noDataLatest.play()
                    }
                    self.cricketLatestResults = self.leagueDetailsViewModel.cricketLatestResults
                    self.latestResultCollectionView.reloadData()
                }
            }
        }else{
            leagueDetailsViewModel.getLatestResult(sportType: sport!, leagueId: leagueId!)
            leagueDetailsViewModel.bindLatestResultsToLeagueDetailsViewController = {() in
                DispatchQueue.main.async {
                    self.latestResults = self.leagueDetailsViewModel.latestResults
                    if self.leagueDetailsViewModel.latestResults.result?.count == nil {
                        self.latestResultCollectionView.isHidden = true
                        self.noDataLatest.isHidden = false
                        self.noDataLatest.contentMode = .scaleAspectFit
                        self.noDataLatest.loopMode = .loop
                        self.noDataLatest.play()
                    }
                    
                    self.latestResultCollectionView.reloadData()
                }
            }
        }
        leagueDetailsViewModel.getTeams(sportType: sport!, leagueId: leagueId!)
        leagueDetailsViewModel.bindTeamsToLeagueDetailsViewController = {() in
            DispatchQueue.main.async {
                self.teams = self.leagueDetailsViewModel.teams
                if self.sport != "tennis"{
                    if self.teams?.result.count == nil{
                        self.teamsCollectionView.isHidden = true
                        self.noDataTeams.isHidden = false
                        self.noDataTeams.contentMode = .scaleAspectFit
                        self.noDataTeams.loopMode = .loop
                        self.noDataTeams.play()
                    }
                }
                self.fixtureActiviyIndicator.stopAnimating()
                self.view.isUserInteractionEnabled = true
                self.UpComingCollectionView.reloadData()
                self.teamsCollectionView.reloadData()
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
            return tennisTeams.count
        }
        return teams?.result.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == UpComingCollectionView{
            let cell = UpComingCollectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? UpComingEventsCollectionViewCell
            cell?.layer.borderWidth = 1
            cell?.layer.cornerRadius = 25
            cell?.layer.borderColor = UIColor.orange.cgColor
            
            if sport == "tennis"{
                var image1 = upComingEvents?.result?[indexPath.row].event_first_player_logo
                if image1 == nil{
                    image1 = ""
                }
                cell?.teamOneImage.sd_imageIndicator = SDWebImageActivityIndicator.gray
                cell?.teamOneImage.sd_setImage(with: URL(string:image1!), placeholderImage: UIImage(named: sport ?? ""))
                cell?.teamOneLabel.text = upComingEvents?.result?[indexPath.row].event_first_player
                
                var image2 = upComingEvents?.result?[indexPath.row].event_second_player_logo
                if image2 == nil{
                    image2 = ""
                }
                cell?.teamTwoImage.sd_imageIndicator = SDWebImageActivityIndicator.gray
                cell?.teamTwoImage.sd_setImage(with: URL(string:image2!), placeholderImage: UIImage(named: sport ?? ""))
                cell?.teamTwoLabel.text = upComingEvents?.result?[indexPath.row].event_second_player
                
                cell?.date.text = upComingEvents?.result?[indexPath.row].event_date
                cell?.time.text = upComingEvents?.result?[indexPath.row].event_time
                return cell!
            }
//============================================================================================================================================
            else if sport == "cricket"{
                
                var image1 = upComingEvents?.result?[indexPath.row].event_home_team_logo
                if image1 == nil{
                    image1 = ""
                }
                cell?.teamOneImage.sd_imageIndicator = SDWebImageActivityIndicator.gray
                cell?.teamOneImage.sd_setImage(with: URL(string:image1!), placeholderImage: UIImage(named: (sport ?? "")))
                cell?.teamOneLabel.text = upComingEvents?.result?[indexPath.row].event_home_team
                
                var image2 = upComingEvents?.result?[indexPath.row].event_away_team_logo
                if image2 == nil{
                    image2 = ""
                }
                cell?.teamTwoImage.sd_imageIndicator = SDWebImageActivityIndicator.gray
                cell?.teamTwoImage.sd_setImage(with: URL(string:image2!), placeholderImage: UIImage(named: (sport ?? "")))
                cell?.teamTwoLabel.text = upComingEvents?.result?[indexPath.row].event_away_team
                cell?.date.text = upComingEvents?.result?[indexPath.row].event_date_start!
                cell?.time.text = upComingEvents?.result?[indexPath.row].event_time
                return cell!
                
            }else if sport == "basketball" {
                var image1 = upComingEvents?.result?[indexPath.row].event_home_team_logo
                if image1 == nil{
                    image1 = ""
                }
                cell?.teamOneImage.sd_imageIndicator = SDWebImageActivityIndicator.gray
                cell?.teamOneImage.sd_setImage(with: URL(string:image1!), placeholderImage: UIImage(named: (sport ?? "")))
                cell?.teamOneLabel.text = upComingEvents?.result?[indexPath.row].event_home_team
                
                var image2 = upComingEvents?.result?[indexPath.row].event_away_team_logo
                if image2 == nil{
                    image2 = ""
                }
                cell?.teamTwoImage.sd_imageIndicator = SDWebImageActivityIndicator.gray
                cell?.teamTwoImage.sd_setImage(with: URL(string:image2!), placeholderImage: UIImage(named: (sport ?? "")))
                cell?.teamTwoLabel.text = upComingEvents?.result?[indexPath.row].event_away_team
                    cell?.date.text = upComingEvents?.result?[indexPath.row].event_date
                cell?.time.text = upComingEvents?.result?[indexPath.row].event_time
                return cell!
            }
//============================================================================================================================================
            else{
                
                var image1 = upComingEvents?.result?[indexPath.row].home_team_logo
                if image1 == nil{
                    image1 = ""
                }
                cell?.teamOneImage.sd_imageIndicator = SDWebImageActivityIndicator.gray
                cell?.teamOneImage.sd_setImage(with: URL(string:image1!), placeholderImage: UIImage(named: (sport ?? "")))
                cell?.teamOneLabel.text = upComingEvents?.result?[indexPath.row].event_home_team
                
                var image2 = upComingEvents?.result?[indexPath.row].away_team_logo
                if image2 == nil{
                    image2 = ""
                }
                cell?.teamTwoImage.sd_imageIndicator = SDWebImageActivityIndicator.gray
                cell?.teamTwoImage.sd_setImage(with: URL(string:image2!), placeholderImage: UIImage(named: (sport ?? "")))
                cell?.teamTwoLabel.text = upComingEvents?.result?[indexPath.row].event_away_team
                
                cell?.date.text = upComingEvents?.result?[indexPath.row].event_date
                cell?.time.text = upComingEvents?.result?[indexPath.row].event_time
                return cell!
                
            }
            
            
//************************************************************************************************************************************************
            
        }else if collectionView == latestResultCollectionView{
            let cell = latestResultCollectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? LatestResultCollectionViewCell
            cell?.layer.borderWidth = 1
            cell?.layer.cornerRadius = 25
            cell?.layer.borderColor = UIColor.orange.cgColor
            
            if sport == "tennis"{
                
                cell?.teamOneImage.image =  UIImage(named: sport ?? "")
                cell?.teamOneLabel.text = latestResults?.result?[indexPath.row].event_first_player
                
                cell?.teamTwoImage.image =  UIImage(named: sport ?? "")
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
                    cell?.teamOneImage.sd_imageIndicator = SDWebImageActivityIndicator.gray
                    cell?.teamOneImage.sd_setImage(with: URL(string:image1!), placeholderImage: UIImage(named: (sport ?? "")))
                    cell?.teamOneLabel.text = cricketLatestResults?.result[indexPath.row].eventHomeTeam
                    
                    var image2 = cricketLatestResults?.result[indexPath.row].eventAwayTeamLogo
                    if image2 == nil{
                        image2 = ""
                    }
                    cell?.teamTwoImage.sd_imageIndicator = SDWebImageActivityIndicator.gray
                    cell?.teamTwoImage.sd_setImage(with: URL(string:image2!), placeholderImage: UIImage(named: (sport ?? "")))
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
                cell?.teamOneImage.sd_imageIndicator = SDWebImageActivityIndicator.gray
                cell?.teamOneImage.sd_setImage(with: URL(string:image1!), placeholderImage: UIImage(named: (sport ?? "")))
                cell?.teamOneLabel.text = latestResults?.result?[indexPath.row].event_home_team
                
                var image2 = latestResults?.result?[indexPath.row].away_team_logo
                if image2 == nil{
                    image2 = ""
                }
                cell?.teamTwoImage.sd_imageIndicator = SDWebImageActivityIndicator.gray
                cell?.teamTwoImage.sd_setImage(with: URL(string:image2!), placeholderImage: UIImage(named: (sport ?? "")))
                cell?.teamTwoLabel.text = latestResults?.result?[indexPath.row].event_away_team
                
                cell?.dateLabel.text = latestResults?.result?[indexPath.row].event_date
                cell?.timeLabel.text = latestResults?.result?[indexPath.row].event_time
                cell?.scoreLabel.text = latestResults?.result?[indexPath.row].event_final_result
                
                return cell!
            }
            
        }
        
//***************************************************************************************************************************************

        
        let cell2 = teamsCollectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? TeamsCollectionViewCell
        cell2?.layer.borderWidth = 1
        cell2?.layer.cornerRadius = (cell2?.frame.height)!/2
        cell2?.layer.borderColor = UIColor.orange.cgColor
        if sport == "cricket" {
            var image1 = teams?.result[indexPath.row].team_logo
            if image1 == nil{
                image1 = ""
            }
            cell2?.teamImage.sd_imageIndicator = SDWebImageActivityIndicator.gray
            cell2?.teamImage.sd_setImage(with: URL(string:image1!), placeholderImage: UIImage(named: (sport ?? "")))
            return cell2!
        }else if sport == "tennis"{
            cell2?.teamImage.image = UIImage(named: sport ?? "")
            return cell2!
        }else{
            var image1 = teams?.result[indexPath.row].team_logo
            if image1 == nil{
                image1 = ""
            }
            cell2?.teamImage.sd_imageIndicator = SDWebImageActivityIndicator.gray
            cell2?.teamImage.sd_setImage(with: URL(string:image1!), placeholderImage: UIImage(named: (sport ?? "")))
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
        if InternetConnection().isConnectedToNetwork() == true{
            
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
        }else{
            let alert = UIAlertController(title: "Warrning!", message: "There is no Internet Connection",preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok",style: .default,handler: {(_: UIAlertAction!) in
                alert.dismiss(animated: true)
            }))
            self.present(alert, animated: true, completion: nil)
        }
    }
}
