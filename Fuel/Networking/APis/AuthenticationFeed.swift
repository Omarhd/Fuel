//
//  AuthenticationFeed.swift
//  Fuel Admin
//
//  Created by Omar Abdulrahman on 2/28/22.//

import Foundation
enum AuthenticationFeed {
    case adminLogin
}

extension AuthenticationFeed: Endpoint {
    var base: String {
        return BuildSettingsKey.BaseURL.value
    }
    
    var path: String {
        switch self {
        case .adminLogin:
            return "http://127.0.0.1:8000/users/login"
        }
    }
}
