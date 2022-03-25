//
//  ShipmentModel.swift
//  Fuel Admin
//
//  Created by Omar Abdulrahman on 2/28/22.
//

import Foundation

struct CreateShipmentRequest: Encodable {
    let adminID: String
    let shipmentBatchNumber: Int
    let shipmentQuantity: Int
    
    enum CodingKeys: String, CodingKey {
        case adminID = "admin_id"
        case shipmentBatchNumber = "shipment_number"
        case shipmentQuantity = "quantity"
    }
}

// MARK: - ShipmentResponse
struct ShipmentResponse: Codable {
    let id: String
    let shipmentNumber: Int
    let status, qr: String
    let quantity: Int
    let createdAt, updatedAt, adminID: String
    let currentHolder: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case shipmentNumber = "shipment_number"
        case status, qr, quantity, createdAt, updatedAt
        case adminID = "admin_id"
        case currentHolder = "current_holder"
    }
}

// MARK: - ChangeShipmentHolder
struct ChangeShipmentHolder: Codable {
    let shipmentID, userID: String
    
    enum CodingKeys: String, CodingKey {
        case shipmentID = "shipment_id"
        case userID = "user_id"
    }
}

// MARK: - ChangeShipmentHolder
struct RefuseShipmentRequest: Codable {
    let shipmentID: String
    let userID: String
    
    enum CodingKeys: String, CodingKey {
        case shipmentID = "shipment_id"
        case userID = "user_id"
    }
}

// MARK: - ChangeShipmentHolderResponse
struct ChangeShipmentHolderResponse: Codable {
    let id: String
    let shipmentNumber: Int
    let status, qr: String
    let quantity: Int
    let createdAt, updatedAt, adminID, currentHolder: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case shipmentNumber = "shipment_number"
        case status, qr, quantity, createdAt, updatedAt
        case adminID = "admin_id"
        case currentHolder = "current_holder"
    }
}

enum ShipmentsStatus: String, CaseIterable {
    
    case REFUSED = "refused"
    case NEW = "new"
    case RECIVED = "recived"
    case SOLD = "sold"
    case RETAILED = "retailed"
}


// MARK: - AgentModel
struct AgentModel: Codable {
    let id, firstName, lastName, email: String
    let password, phoneNumber, nationalNumber, type: String
    let createdAt, updatedAt, createdBy: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case firstName = "first_name"
        case lastName = "last_name"
        case email, password
        case phoneNumber = "phone_number"
        case nationalNumber = "national_number"
        case type, createdAt, updatedAt
        case createdBy = "created_by"
    }
}

// MARK: - RetailsShipmentResponse
struct RetailsShipmentResponse: Codable {
    let quantity, retailShipmentNumber: Int
    let status, agentID, shipmentID, id: String
    let updatedAt, createdAt: String
    
    enum CodingKeys: String, CodingKey {
        case quantity
        case retailShipmentNumber = "retailShipment_number"
        case status
        case agentID = "agent_id"
        case shipmentID = "shipment_id"
        case id, updatedAt, createdAt
    }
}

// MARK: - ReShipmentRequest
struct ReShipmentRequest: Codable {
    let shipmentID, agentID: String
    let quantity: Int

    enum CodingKeys: String, CodingKey {
        case shipmentID = "shipment_id"
        case agentID = "agent_id"
        case quantity
    }
}



// MARK: - GetUserResponse
struct GetUserResponse: Codable {
    let id, firstName, lastName, email: String
    let password, phoneNumber, nationalNumber, type: String
    let createdAt, updatedAt, createdBy: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case firstName = "first_name"
        case lastName = "last_name"
        case email, password
        case phoneNumber = "phone_number"
        case nationalNumber = "national_number"
        case type, createdAt, updatedAt
        case createdBy = "created_by"
    }
}

