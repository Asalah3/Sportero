//
//  LiveScore.swift
//  Sportero
//
//  Created by Asalah Sayed on 07/05/2023.
//

import Foundation
struct Livescore: Codable {
    let success: Int
    let result: [LivescoreResult]?
}
struct LivescoreResult: Codable {
    let event_key: Int?
    let event_date: String
    let event_time: String
    let event_home_team: String?
    let home_team_key: Int?
    let event_away_team: String?
    let away_team_key: Int?
    let event_halftime_result: String?
    let event_final_result: String?
    let event_ft_result: String?
    let event_penalty_result: String?
    let event_status: String?
    let country_name: String?
    let league_name: String?
    let league_key: Int?
    let league_round: String?
    let league_season: String?
    let event_live: String?
    let event_stadium: String?
    let event_referee: String?
    let home_team_logo: String?
    let away_team_logo: String?
    let event_country_key: Int?
    let league_logo: String?
    let country_logo: String?
    let event_home_formation: String?
    let event_away_formation: String?
    let fk_stage_key: Int?
    let stage_name: String?
    let event_quarter: String?
    let event_home_team_logo: String?
    let event_away_team_logo: String?
    let event_first_player: String?
    let first_player_key: Int?
    let event_second_player: String?
    let second_player_key: Int?
    let event_game_result: String?
    let event_serve: String?
    let event_winner: String?
    let event_first_player_logo: String?
    let event_second_player_logo: String?
    let event_date_start: String?
    let event_date_stop: String?
    let event_service_home: String?
    let event_service_away: String?
    let event_home_final_result: String?
    let event_away_final_result: String?
    let event_home_rr: String?
    let event_away_rr: String?
    let event_status_info: String?
    let event_type: String?
    let event_toss: String?
    let event_man_of_match: String?
}
struct CricketLivescore: Decodable {
    let success: Int
    let result: [CricketLivescoreResult]
}

// MARK: - Result
struct CricketLivescoreResult: Decodable {
    let eventKey: Int
    let eventDateStart, eventDateStop, eventTime, eventHomeTeam: String
    let homeTeamKey: Int
    let eventAwayTeam: String
    let awayTeamKey: Int
    let eventServiceHome, eventServiceAway, eventHomeFinalResult, eventAwayFinalResult: String
    let eventStatus, eventStatusInfo, leagueName: String
    let leagueKey: Int
    let leagueRound, leagueSeason, eventLive, eventType: String
    let eventToss, eventManOfMatch, eventStadium: String
    let eventHomeTeamLogo, eventAwayTeamLogo: String?

    enum CodingKeys: String, CodingKey {
        case eventKey = "event_key"
        case eventDateStart = "event_date_start"
        case eventDateStop = "event_date_stop"
        case eventTime = "event_time"
        case eventHomeTeam = "event_home_team"
        case homeTeamKey = "home_team_key"
        case eventAwayTeam = "event_away_team"
        case awayTeamKey = "away_team_key"
        case eventServiceHome = "event_service_home"
        case eventServiceAway = "event_service_away"
        case eventHomeFinalResult = "event_home_final_result"
        case eventAwayFinalResult = "event_away_final_result"
        case eventStatus = "event_status"
        case eventStatusInfo = "event_status_info"
        case leagueName = "league_name"
        case leagueKey = "league_key"
        case leagueRound = "league_round"
        case leagueSeason = "league_season"
        case eventLive = "event_live"
        case eventType = "event_type"
        case eventToss = "event_toss"
        case eventManOfMatch = "event_man_of_match"
        case eventStadium = "event_stadium"
        case eventHomeTeamLogo = "event_home_team_logo"
        case eventAwayTeamLogo = "event_away_team_logo"
    }
}
