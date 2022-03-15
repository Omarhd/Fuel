//
//  ServicesFeed.swift
//  Fuel Admin
//
//  Created by Omar Abdulrahman on 2/28/22.
//

import Foundation

enum ServicesFeed {
    case acceptShipment
    case refuseShipment
    case getMyShipments(String)
    case getLastShipment(String)
    case getAllRetaildShipments
    case getAgentByID(String)
    case createUsers
    case updateUser
    case deleteUser(String)
    case getAllUsers
    case getOperations  
}

extension ServicesFeed: Endpoint {
    var base: String {
        return "http://192.168.8.100:8000"
    }
    
    var path: String {
        switch self {
        case .acceptShipment:
            return "/shipments/shipment/holder"
        case .refuseShipment: return "/shipments/shipment/refuse"
        case .getMyShipments(let ID): return "/shipments/shipment/\(ID)/user"
        case .getLastShipment(let shipmentID): return "/shipments/shipment/\(shipmentID)"
        case .getAllRetaildShipments: return "/retailShipments/retailShipments"
        case .getAgentByID(let agentID): return "users/user/\(agentID)"
        case .createUsers: return "/users/user"
        case .updateUser: return "/users/user"
        case .deleteUser(let userID): return "/users/user/\(userID)"
        case .getAllUsers: return "/users/users"
        case .getOperations: return "/operation/operations"
        }
    }
}
