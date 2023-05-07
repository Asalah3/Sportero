//
//  FavouriteViewModel.swift
//  Sportero
//
//  Created by Asalah Sayed on 07/05/2023.
//

import Foundation
import CoreData
class FavouriteViewModel{
    var bindResultToFavouriteViewController : (() ->()) = {}
    var Result : [NSManagedObject] = []
    var teamResult : Teams!{
        didSet{
            bindResultToFavouriteViewController()
        }
    }
    func getTeamResult(sportType: String, teamId:Int){
        NetworkServices().fetchSingleTeamResult(sport: sportType, teamId: teamId){(data) in
            guard let result = data else {return}
            self.teamResult = result
        }
    }
    func getFavouritesResult(){
        self.Result = FavouriteItems.favouriteItems.fetchFavouriteItems()
        print("Result =  \(Result.count)")
    }
    
    func deleteFavouriteItem(favouriteItem : NSManagedObject){
        FavouriteItems.favouriteItems.deleteItem(favouriteItem: favouriteItem)
    }
}
