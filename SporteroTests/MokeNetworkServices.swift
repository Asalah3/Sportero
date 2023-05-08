//
//  MokeNetworkServices.swift
//  SporteroTests
//
//  Created by Asalah Sayed on 08/05/2023.
//

import Foundation
@testable import Sportero

class MokeNetworkServices{
    let mokeLeaguesResponse = "{\"success\":1,\"result\":[{\"league_key\":4,\"league_name\":\"UEFA Europa League\",\"country_key\":1,\"country_name\":\"eurocups\",\"league_logo\":\"\",\"country_logo\":null}]}"
    let mokeFixtureResponse = "{\"success\":1,\"result\":[{\"team_key\":74,\"team_name\":\"Salzburg\",\"team_logo\":\"\",\"players\":[{\"player_key\":554337339,\"player_name\":\"N. Okafor\",\"player_number\":\"77\",\"player_country\":null,\"player_type\":\"Forwards\",\"player_age\":\"22\",\"player_match_played\":\"21\",\"player_goals\":\"7\",\"player_yellow_cards\":\"2\",\"player_red_cards\":\"0\",\"player_image\":\"\"}]}]}"
    let mokeTeamsResponse = "{\"success\":1,\"result\":[{\"team_key\":74,\"team_name\":\"Salzburg\",\"team_logo\":\"\",\"players\":[{\"player_key\":554337339,\"player_name\":\"N. Okafor\",\"player_number\":\"77\",\"player_country\":null,\"player_type\":\"Forwards\",\"player_age\":\"22\",\"player_match_played\":\"21\",\"player_goals\":\"7\",\"player_yellow_cards\":\"2\",\"player_red_cards\":\"0\",\"player_image\":\"\"}]}]}"
    let mokeLiveScoreResponse = "{\"success\":1,\"result\":[{\"event_key\":1183019,\"event_date\":\"2023-05-08\",\"event_time\":\"01:20\",\"event_home_team\":\"Millonarios\",\"home_team_key\":2273,\"event_away_team\":\"Santa Fe\",\"away_team_key\":2269,\"event_halftime_result\":\"1 - 0\",\"event_final_result\":\"1 - 0\",\"event_ft_result\":\"\",\"event_penalty_result\":\"\",\"event_status\":\"Half Time\",\"country_name\":\"Colombia\",\"league_name\":\"Primera A - Apertura\",\"league_key\":120,\"league_round\":\"Round 18\",\"league_season\":\"2023\",\"event_live\":\"1\",\"event_stadium\":\"Estadio Nemesio Camacho El Campin, Bogota\",\"event_referee\":\"Wilmar Roldan, Colombia\",\"home_team_logo\":\" \",\"away_team_logo\":\" \",\"event_country_key\":34,\"league_logo\":\" \",\"country_logo\":\" \",\"event_home_formation\":\"4-2-3-1\",\"event_away_formation\":\"4-2-3-1\",\"fk_stage_key\":813,\"stage_name\":\"Apertura\",\"league_group\":null}]}"
    let mokeCricketLivescoreResponse = "{\"success\":1,\"result\":[{\"event_key\":6880,\"event_date_start\":\"2023-04-20\",\"event_date_stop\":\"2023-04-20\",\"event_time\":\"18:00\",\"event_home_team\":\"New Zealand\",\"home_team_key\":206,\"event_away_team\":\"Pakistan\",\"away_team_key\":170,\"event_service_home\":\"18.5 20 ov\",\"event_service_away\":\"\",\"event_home_final_result\":\"164 5\",\"event_away_final_result\":\" \",\"event_home_rr\":null,\"event_away_rr\":null,\"event_status\":\"Cancelled\",\"event_status_info\":\"No result\",\"league_name\":\"New Zealand tour of Pakistan\",\"league_key\":8435,\"league_round\":\"4th T20I\",\"league_season\":\"2023\",\"event_live\":\"1\",\"event_type\":\"T20\",\"event_toss\":\"Pakistan, elected to bowl first\",\"event_man_of_match\":\" \",\"event_stadium\":\"Rawalpindi Cricket Stadium\",\"event_home_team_logo\":\" \",\"event_away_team_logo\":\" \"}]}"
    let mokeTennisPlayerResponse = "{\"success\":1,\"result\":[{\"player_key\":37799,\"player_name\":\"Bopanna Ebden\",\"player_country\":null,\"player_bday\":null,\"player_logo\":null}]}"
    let mokeSingleTeamResponse = "{\"success\":1,\"result\":[{\"team_key\":74,\"team_name\":\"Salzburg\",\"team_logo\":\" \",\"players\":[{\"player_key\":848260737,\"player_name\":\"P. Kohn\",\"player_number\":\"18\",\"player_country\":null,\"player_type\":\"Goalkeepers\",\"player_age\":\"25\",\"player_match_played\":\"27\",\"player_goals\":\"0\",\"player_yellow_cards\":\"2\",\"player_red_cards\":\"0\",\"player_image\":\" \"}]}]}"
    
}
extension MokeNetworkServices : NetworkServicesProtocol{
    func fetchLeaguesResult(sport: String, compilitionHandler: @escaping (Sportero.Leagues?) -> Void) {
        let data = Data(mokeLeaguesResponse.utf8)
        do{
            let result = try JSONDecoder().decode(Leagues.self, from: data)
            compilitionHandler(result)
        }catch let error{
            print(error.localizedDescription)
            compilitionHandler(nil)
        }
    }
    
    func fetchFixturesResult(sport: String, leagueId: Int, compilitionHandler: @escaping (Sportero.Fixtures?) -> Void) {
        let data = Data(mokeFixtureResponse.utf8)

        do{
            let result = try JSONDecoder().decode(Fixtures.self, from: data)
            compilitionHandler(result)
        }catch let error{
            print(error.localizedDescription)
            compilitionHandler(nil)
        }
    }
    
    func fetchLiveScoreResult(sport: String, leagueId: Int, compilitionHandler: @escaping (Sportero.Livescore?) -> Void) {
        let data = Data(mokeLiveScoreResponse.utf8)

        do{
            let result = try JSONDecoder().decode(Livescore.self, from: data)
            compilitionHandler(result)
        }catch let error{
            print("Livescore\(error.localizedDescription)")
            compilitionHandler(nil)
        }
    }
    
    func fetchCricketLivescoreResult(leagueId: Int, compilitionHandler: @escaping (Sportero.CricketLivescore?) -> Void) {
        
        let data = Data(mokeCricketLivescoreResponse.utf8)
        do{
            let result = try JSONDecoder().decode(CricketLivescore.self, from: data)
            compilitionHandler(result)
        }catch let error{
            print("Livescore\(error.localizedDescription)")
            compilitionHandler(nil)
        }
    }
    
    func fetchTeamsResult(sport: String, leagueId: Int, compilitionHandler: @escaping (Sportero.Teams?) -> Void) {
        let data = Data(mokeTeamsResponse.utf8)

        do{
            let result = try JSONDecoder().decode(Teams.self, from: data)
            compilitionHandler(result)
        }catch let error{
            print("Teams \(error.localizedDescription)")
            compilitionHandler(nil)
        }
    }
    
    func fetchSingleTeamResult(sport: String, teamId: Int, compilitionHandler: @escaping (Sportero.Teams?) -> Void) {
        let data = Data(mokeSingleTeamResponse.utf8)

        do{
            let result = try JSONDecoder().decode(Teams.self, from: data)
            compilitionHandler(result)
        }catch let error{
            print(error.localizedDescription)
            compilitionHandler(nil)
        }
    }
    
    func fetchTennisPlayerResult(playerId: Int, compilitionHandler: @escaping (Sportero.TennisPlayer?) -> Void) {
        let data = Data(mokeTennisPlayerResponse.utf8)

        do{
            let result = try JSONDecoder().decode(TennisPlayer.self, from: data)
            compilitionHandler(result)
        }catch let error{
            print(error.localizedDescription)
            compilitionHandler(nil)
        }
    }
    
    
}
