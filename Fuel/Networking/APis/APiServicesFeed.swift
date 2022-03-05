//
//  ServicesFeed.swift
//  Fuel Admin
//
//  Created by Omar Abdulrahman on 2/28/22.
//

import Foundation

enum ServicesFeed {
    case createShipments
    case getAllShipments
    case getLastShipment(String)
    case createUsers
    case updateUser
    case deleteUser(String)
    case getAllUsers
    case getOperations
}

extension ServicesFeed: Endpoint {
    var base: String {
        return BuildSettingsKey.BaseURL.value
    }
    
    var path: String {
        switch self {
        case .createShipments:
            return "http://127.0.0.1:8000/shipments/shipment"
        case .getAllShipments: return "http://127.0.0.1:8000/shipments/shipments"
        case .getLastShipment(let shipmentID): return "http://127.0.0.1:8000/shipments/shipment/\(shipmentID)"
        case .createUsers: return "http://127.0.0.1:8000/users/user"
        case .updateUser: return "http://127.0.0.1:8000/users/user"
        case .deleteUser(let userID): return "http://127.0.0.1:8000/users/user/\(userID)"
        case .getAllUsers: return "http://127.0.0.1:8000/users/users"
        case .getOperations: return "http://127.0.0.1:8000/operation/operations"
        }
    }
}
