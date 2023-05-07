//
//  LeaguesViewModal.swift
//  Sportero
//
//  Created by Asalah Sayed on 07/05/2023.
//

import Foundation
class LeaguesViewModel{
    var bindResultToLeagueViewController : (() ->()) = {}
    var leaguesResult : Leagues!{
        didSet{
            bindResultToLeagueViewController()
        }
    }
    func getLeaguesResult(sportType : String){
        NetworkServices().fetchLeaguesResult(sport: sportType){(data) in
            guard let result = data else {return}
            self.leaguesResult = result
        }
    }
}
