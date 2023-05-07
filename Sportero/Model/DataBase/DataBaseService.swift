//
//  FavouriteTeam.swift
//  Sportero
//
//  Created by Asalah Sayed on 06/05/2023.
//

import Foundation
import UIKit
import CoreData
class FavouriteItems{
    var context : NSManagedObjectContext?
    var entity : NSEntityDescription?
    static var favouriteItems = FavouriteItems()
    
    private init() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        context = appDelegate.persistentContainer.viewContext
        entity = NSEntityDescription.entity(forEntityName: "FavouriteItem", in: context!)
    }
    
    
    func InsertItem(favouriteName : String , favouriteId : Int , sportType : String){
        let newTeam = NSManagedObject(entity: entity!, insertInto: context)
        newTeam.setValue(favouriteName, forKey: "favouriteName")
        newTeam.setValue(favouriteId, forKey: "favouriteId")
        newTeam.setValue(sportType, forKey: "sportType")
        do {
            try context?.save()
            print("\(favouriteName) Inserted")
         } catch {
          print("Error saving")
        }
    }
    func deleteItem(favouriteItem : NSManagedObject){
                do {
                    context?.delete(favouriteItem)
                    try context?.save()
                  } catch {
                    
                    print("Failed")
                }
    }
    
    func fetchFavouriteItems() -> [NSManagedObject]{
        var favouritesList : [NSManagedObject]?
        favouritesList = []
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "FavouriteItem")
        request.returnsObjectsAsFaults = false
        do {
            let result = try context?.fetch(request)
            for data in result as! [NSManagedObject]{
                favouritesList?.append(data)
                print(data.value(forKey: "favouriteName") as! String)
            }
        } catch {
            print("Failed")
        }
        return favouritesList!
    }
    
    func checkIfInserted(favouriteId : Int) -> Bool {
        var result = false
        var favouritesList : [NSManagedObject]?
        favouritesList = FavouriteItems.favouriteItems.fetchFavouriteItems()
        favouritesList?.forEach{ data in
            let favId = data.value(forKey: "favouriteId") as! Int
            if favId == favouriteId{
                result = true
            }else{
                result = false
            }
        }
        return result
    }
    
}
