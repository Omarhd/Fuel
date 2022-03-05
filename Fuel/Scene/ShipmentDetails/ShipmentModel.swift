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
