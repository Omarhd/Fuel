//
//  RetaildShipmentTableViewCell.swift
//  Fuel
//
//  Created by Omar Abdulrahman on 3/15/22.
//

import UIKit

class RetaildShipmentTableViewCell: UITableViewCell {

    var shipmentData: RetailsShipmentResponse?
    
    @IBOutlet weak var quantity: UILabel!
    @IBOutlet weak var batchNumber: UILabel!
    @IBOutlet weak var status: UILabel!
    @IBOutlet weak var createdAt: UILabel!
  
    func setupUI(with shipmentData: RetailsShipmentResponse) {
        self.status.text = shipmentData.shipmentID
        self.createdAt.text = shipmentData.createdAt
    }
}
