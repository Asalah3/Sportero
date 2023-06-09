//
//  TennisPlayerDetailsViewModel.swift
//  Sportero
//
//  Created by Asalah Sayed on 07/05/2023.
//

import Foundation
class TennisPlayerDetailsViewModel{
    var bindResultToTennisPlayerDetailsViewController : (() ->()) = {}
    var playerResult : TennisPlayer!{
        didSet{
            bindResultToTennisPlayerDetailsViewController()
        }
    }
    func getTennisPlayerResult(playerId : Int){
        NetworkServices().fetchTennisPlayerResult(playerId: playerId){(data) in
            guard let result = data else {return}
            self.playerResult = result
        }
    }
    func deleteItemById(favouriteId : Int){
        FavouriteItems.favouriteItems.deleteItemById(favouriteId: favouriteId)
    }
    func insertPlayer(favouriteName : String , favouriteId : Int , sportType : String){
        FavouriteItems.favouriteItems.InsertItem(favouriteName: favouriteName, favouriteId: favouriteId, sportType: sportType)
    }
    func isExist(favouriteId : Int) -> Bool{
        return FavouriteItems.favouriteItems.checkIfInserted(favouriteId: favouriteId)
    }
}
