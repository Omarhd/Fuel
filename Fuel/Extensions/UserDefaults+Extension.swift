//
//  UserDefaults+Extension.swift
//  Yummie
//
//  Created by Omar on 26/11/2021.
//

import Foundation
extension UserDefaults {
    
    private enum UserDefaultsKeys: String {
        case hasOnBoarded
        case hasLogedIn
        case hasToken
        case hasID
        case hasShipmentID
    }
    
    var hasOnBoarded: Bool {
        get {
            bool(forKey: UserDefaultsKeys.hasOnBoarded.rawValue)
        }
        set {
            set(newValue, forKey: UserDefaultsKeys.hasOnBoarded.rawValue)
        }
    }
    
    var hasLogedIn: Bool {
        get {
            bool(forKey: UserDefaultsKeys.hasLogedIn.rawValue)
        }
        set {
            set(newValue, forKey: UserDefaultsKeys.hasLogedIn.rawValue)
        }
    }
    
    var hasToken: String {
        get {
            value(forKey: UserDefaultsKeys.hasToken.rawValue) as! String
        }
        set {
            set(newValue, forKey: UserDefaultsKeys.hasToken.rawValue)
        }
    }
    
    var hasID: String {
        get {
            value(forKey: UserDefaultsKeys.hasID.rawValue) as! String
        }
        set {
            set(newValue, forKey: UserDefaultsKeys.hasID.rawValue)
        }
    }
    
    var hasShipmentID: String {
        get {
            value(forKey: UserDefaultsKeys.hasShipmentID.rawValue) as! String
        }
        set {
            set(newValue, forKey: UserDefaultsKeys.hasShipmentID.rawValue)
        }
    }
}
