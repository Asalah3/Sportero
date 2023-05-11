//
//  NetworkServices.swift
//  Sportero
//
//  Created by Asalah Sayed on 03/05/2023.
//

import Foundation
protocol NetworkServicesProtocol {
    func fetchLeaguesResult(sport : String,compilitionHandler : @escaping (Leagues?)-> Void)
    func fetchFixturesResult(sport : String,leagueId : Int ,compilitionHandler : @escaping (Fixtures?)-> Void)
    func fetchLiveScoreResult(sport: String, leagueId: Int, compilitionHandler: @escaping (Livescore?) -> Void)
    func fetchCricketLivescoreResult(leagueId: Int, compilitionHandler: @escaping (CricketLivescore?) -> Void)
    func fetchTeamsResult(sport: String, leagueId: Int, compilitionHandler: @escaping (Teams?) -> Void)
    func fetchSingleTeamResult(sport: String, teamId: Int, compilitionHandler: @escaping (Teams?) -> Void)
    func fetchTennisPlayerResult(playerId: Int, compilitionHandler: @escaping (TennisPlayer?) -> Void)
}

class NetworkServices : NetworkServicesProtocol{
    func fetchTennisPlayerResult(playerId: Int, compilitionHandler: @escaping (TennisPlayer?) -> Void) {
        let url = URL(string: "https://apiv2.allsportsapi.com/tennis/?met=Players&playerId=\(playerId)&APIkey=74239ff4b0776dba5295debe45f7691ae79a6ed3ce907cacb868ab9107212fd4")
        guard let newUrl = url else {
            return
        }
        let request = URLRequest(url: newUrl)
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: request){ data,response , error in
            do{
                let result = try JSONDecoder().decode(TennisPlayer.self, from: data!)
                compilitionHandler(result)
            }catch let error{
                print(error.localizedDescription)
                compilitionHandler(nil)
            }
            
        }
        task.resume()
    }
    
    
    func fetchSingleTeamResult(sport: String, teamId: Int, compilitionHandler: @escaping (Teams?) -> Void) {
        let url = URL(string: "https://apiv2.allsportsapi.com/\(sport)/?met=Teams&teamId=\(teamId)&APIkey=963d29cf248e5645a1d194a9fca0c26304519aa57383aeadfc6bf6a954af3d92")
        guard let newUrl = url else {
            return
        }
        let request = URLRequest(url: newUrl)
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: request){ data,response , error in
            do{
                let result = try JSONDecoder().decode(Teams.self, from: data!)
                compilitionHandler(result)
            }catch let error{
                print(error.localizedDescription)
                compilitionHandler(nil)
            }
            
        }
        task.resume()
    }
    
    func fetchTeamsResult(sport: String, leagueId: Int, compilitionHandler: @escaping (Teams?) -> Void) {
        let url = URL(string: "https://apiv2.allsportsapi.com/\(sport)/?met=Teams&leagueId=\(leagueId)&APIkey=963d29cf248e5645a1d194a9fca0c26304519aa57383aeadfc6bf6a954af3d92")
        
        guard let newUrl = url else {
            return
        }
        let request = URLRequest(url: newUrl)
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: request){ data,response , error in
            do{
                let result = try JSONDecoder().decode(Teams.self, from: data!)
                compilitionHandler(result)
            }catch let error{
                print("Teams \(error.localizedDescription)")
                compilitionHandler(nil)
            }
            
        }
        task.resume()
    }
    func fetchFixturesResult(sport : String,leagueId : Int ,compilitionHandler : @escaping (Fixtures?)-> Void) {
//        let todayDate = Date()
//        let calender = Calendar.current
//        let dateFormatter = DateFormatter()
//        dateFormatter.dateFormat = "YYYY-MM-dd"
//        dateFormatter.locale = Locale(identifier: "en")
//        let weekStart = calender.date(byAdding: .day, value: 10, to: todayDate)
//        let today = dateFormatter.string(from: todayDate)
//        let weekAhead = dateFormatter.string(from: weekStart!)
        
        
        let url = URL(string: "https://apiv2.allsportsapi.com/\(sport)/?met=Fixtures&leagueId=\(leagueId)&APIkey=963d29cf248e5645a1d194a9fca0c26304519aa57383aeadfc6bf6a954af3d92&from=\(DateUtils.getCurrentDate())&to=\(DateUtils.getToDate())")
        guard let newUrl = url else {
            return
        }
        let request = URLRequest(url: newUrl)
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: request){ data,response , error in
            do{
                let result = try JSONDecoder().decode(Fixtures.self, from: data!)
                compilitionHandler(result)
            }catch let error{
                print(error.localizedDescription)
                compilitionHandler(nil)
            }
            
        }
        task.resume()
    }
    
    func fetchLiveScoreResult(sport: String, leagueId: Int, compilitionHandler: @escaping (Livescore?) -> Void) {
        let url = URL(string: "https://apiv2.allsportsapi.com/\(sport)/?met=Livescore&leagueId=\(leagueId)&APIkey=963d29cf248e5645a1d194a9fca0c26304519aa57383aeadfc6bf6a954af3d92")
        guard let newUrl = url else {
            return
        }
        let request = URLRequest(url: newUrl)
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: request){ data,response , error in
            do{
                let result = try JSONDecoder().decode(Livescore.self, from: data!)
                compilitionHandler(result)
            }catch let error{
                print("Livescore\(error.localizedDescription)")
                compilitionHandler(nil)
            }
            
        }
        task.resume()
    }
    
    func fetchLeaguesResult(sport: String, compilitionHandler: @escaping (Leagues?) -> Void) {
        let url = URL(string: "https://apiv2.allsportsapi.com/\(sport)/?met=Leagues&APIkey=963d29cf248e5645a1d194a9fca0c26304519aa57383aeadfc6bf6a954af3d92")
        
        guard let newUrl = url else {
            return
        }
        let request = URLRequest(url: newUrl)
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: request){ data,response , error in
            do{
                let result = try JSONDecoder().decode(Leagues.self, from: data!)
                compilitionHandler(result)
            }catch let error{
                print(error.localizedDescription)
                compilitionHandler(nil)
            }
            
        }
        task.resume()
        
    }
    func fetchCricketLivescoreResult(leagueId: Int, compilitionHandler: @escaping (CricketLivescore?) -> Void) {
        let url = URL(string: "https://apiv2.allsportsapi.com/cricket/?met=Livescore&APIkey=963d29cf248e5645a1d194a9fca0c26304519aa57383aeadfc6bf6a954af3d92&leagueId=\(leagueId)")
        guard let newUrl = url else {
            return
        }
        let request = URLRequest(url: newUrl)
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: request){ data,response , error in
            do{
                let result = try JSONDecoder().decode(CricketLivescore.self, from: data!)
                print("\(result)")
                compilitionHandler(result)
            }catch let error{
                print("Livescore\(error.localizedDescription)")
                compilitionHandler(nil)
            }
            
        }
        task.resume()
    }
    
    
}
