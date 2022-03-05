//
//  AppManager.swift
//  LemonStore
//
//  Created by Abubakr Haydar on 21/06/1443 AH.
//

import Foundation
let kAppToken = "AppToken"
let kUserObject = "UserObject"


class AppManager: NSObject {
    static let sharedInstance: AppManager = AppManager()
    private let userDefaults = UserDefaults.standard
    private let encoder = JSONEncoder()
    private let decoder = JSONDecoder()
    
    func saveAppToken(token: String) {
        userDefaults.set(token, forKey: kAppToken)
        userDefaults.synchronize()
    }
    func getAppToken() -> String?{
        return userDefaults.string(forKey: kAppToken)
    }
    
//    func saveUserInfoObject(user: User)  {
//        if let encoded = try? encoder.encode(user) {
//            userDefaults.setValue(encoded, forKey: kUserObject)
//            userDefaults.synchronize()
//        }
//    }
}
