//
//  AuthenticationFeed.swift
//  Fuel Admin
//
//  Created by Omar Abdulrahman on 2/28/22.//

import Foundation
enum AuthenticationFeed {
    case UsersLogin
}

extension AuthenticationFeed: Endpoint {
    var base: String {
        return "http://192.168.8.100:8000"
    }
    
    var path: String {
        switch self {
        case .UsersLogin:
            return "/users/login"
        }
    }
}
