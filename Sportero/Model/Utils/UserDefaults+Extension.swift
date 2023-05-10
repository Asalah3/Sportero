//
//  UserDefaults+Extension.swift
//  Sportero
//
//  Created by Asalah Sayed on 09/05/2023.
//

import Foundation
extension UserDefaults {
    private enum UserDefaultsKeys : String{
        case hasOnboarded
        
        case darkMode
    }
    var hasOnboarded : Bool {
        get{
            bool(forKey: UserDefaultsKeys.hasOnboarded.rawValue)
        }set{
            set(newValue, forKey: UserDefaultsKeys.hasOnboarded.rawValue)
        }
    }
    var darkMode : Bool {
        get{
            bool(forKey: UserDefaultsKeys.darkMode.rawValue)
        }set{
            set(newValue, forKey: UserDefaultsKeys.darkMode.rawValue)
        }
    }
}
