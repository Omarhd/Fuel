//
//  Configuration.swift
//  LemonStore
//
//  Created by Abubakr Haydar on 21/06/1443 AH.
//

import Foundation

enum BuildSettingsKey: String {
    case BaseURL
    case googleAPIKey
    case appStoreUrl
    var value: String {
        get {
            return Bundle.main.infoDictionary?[self.rawValue] as? String ?? ""
        }
    }
}

