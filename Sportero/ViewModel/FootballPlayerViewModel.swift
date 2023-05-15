//
//  FootballPlayerViewModel.swift
//  Sportero
//
//  Created by Asalah Sayed on 15/05/2023.
//

import Foundation
class FootballPlayerViewModel{
    var bindResultToFootballPlayerViewController : (() ->()) = {}
    var playerResult : FootballPlayer!{
        didSet{
            bindResultToFootballPlayerViewController()
        }
    }
    func getFootballPlayerResult(playerId : Int){
        NetworkServices().fetchFootballPlayerResult(playerId: playerId){(data) in
            guard let result = data else {return}
            self.playerResult = result
        }
    }
//    func deleteItemById(favouriteId : Int){
//        FavouriteItems.favouriteItems.deleteItemById(favouriteId: favouriteId)
//    }
//    func insertPlayer(favouriteName : String , favouriteId : Int , sportType : String){
//        FavouriteItems.favouriteItems.InsertItem(favouriteName: favouriteName, favouriteId: favouriteId, sportType: sportType)
//    }
//    func isExist(favouriteId : Int) -> Bool{
//        return FavouriteItems.favouriteItems.checkIfInserted(favouriteId: favouriteId)
//    }
}
