//
//  LoginModel.swift
//  ZFuel Admin
//
//  Created by Omar Abdulrahman on 2/23/22.
//

import Foundation

struct LoginRequest: Encodable {
    let nationalNumber: String
    let password: String
    
    enum CodingKeys: String, CodingKey {
        case nationalNumber = "national_number"
        case password = "password"
    }
}

struct LoginResponse: Decodable {
    let token: String
    let ID: String
    
    enum CodingKeys: String, CodingKey {
        case ID = "id"
        case token = "token"
    }
}
