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
        return "https://28d5-102-181-47-39.ngrok.io"
    }
    
    var path: String {
        switch self {
        case .UsersLogin:
            return "/users/login"
        }
    }
}
