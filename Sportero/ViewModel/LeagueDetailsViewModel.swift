//
//  LeagueDetailsViewModel.swift
//  Sportero
//
//  Created by Asalah Sayed on 07/05/2023.
//

import Foundation
class LeaguesDetailsViewModel{
    var bindUpComingEventsToLeagueDetailsViewController : (() ->()) = {}
    var bindLatestResultsToLeagueDetailsViewController : (() ->()) = {}
    var bindCricketLatestResultsToLeagueDetailsViewController : (() ->()) = {}
    var bindTeamsToLeagueDetailsViewController : (() ->()) = {}
    var upComingEvents : Fixtures!{
        didSet{
            bindUpComingEventsToLeagueDetailsViewController()
        }
    }
    var latestResults : Livescore!{
        didSet{
            bindLatestResultsToLeagueDetailsViewController()
        }
    }
    var cricketLatestResults : CricketLivescore!{
        didSet{
            bindCricketLatestResultsToLeagueDetailsViewController()
        }
    }
    var teams : Teams!{
        didSet{
            bindTeamsToLeagueDetailsViewController()
        }
    }
    let network = NetworkServices()
    
    // UpComing Events Result
    func getUpComingEvents(sportType : String , leagueId : Int){
        network.fetchFixturesResult(sport: sportType, leagueId: leagueId){(data) in
            guard let result = data else {return}
            self.upComingEvents = result
        }
    }
    // Latest Result
    func getLatestResult(sportType : String , leagueId : Int){
        network.fetchLiveScoreResult(sport: sportType, leagueId: leagueId){(data) in
            guard let result = data else {return}
            self.latestResults = result
        }
    }
    //Cricket latest Result
    func getCricketLatestResult(leagueId : Int){
        network.fetchCricketLivescoreResult(leagueId: leagueId){(data) in
            self.cricketLatestResults = data
        }
    }
    // Teams
    func getTeams(sportType : String , leagueId : Int){
        network.fetchTeamsResult(sport: sportType, leagueId: leagueId){(data) in
//            guard let result = data else {return}
            self.teams = data
        }
    }
}
