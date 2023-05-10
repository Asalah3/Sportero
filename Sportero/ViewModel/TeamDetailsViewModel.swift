//
//  TeamDetailsViewModel.swift
//  Sportero
//
//  Created by Asalah Sayed on 07/05/2023.
//

import Foundation
class TeamDetailsViewModel{
    func insertTeam(favouriteName : String , favouriteId : Int , sportType : String){
        FavouriteItems.favouriteItems.InsertItem(favouriteName: favouriteName, favouriteId: favouriteId, sportType: sportType)
    }
    
    func isExist(favouriteId : Int) -> Bool{
        return FavouriteItems.favouriteItems.checkIfInserted(favouriteId: favouriteId)
    }
}
