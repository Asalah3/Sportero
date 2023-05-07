//
//  Leagues.swift
//  Sportero
//
//  Created by Asalah Sayed on 03/05/2023.
//

import Foundation
// MARK: - Leagues
struct Leagues: Decodable {
    let success: Int
    let result: [Result]
}

// MARK: - Result
struct Result: Decodable {
    let leagueKey: Int
    let leagueName: String
    let leagueLogo : String?

    enum CodingKeys: String, CodingKey {
        case leagueKey = "league_key"
        case leagueName = "league_name"
        case leagueLogo = "league_logo"
    }
}


