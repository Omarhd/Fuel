//
//  ShipmentTableViewCell.swift
//  Fuel Admin
//
//  Created by Omar Abdulrahman on 3/1/22.
//

import UIKit

class ShipmentTableViewCell: UITableViewCell {

    var shipmentData: ShipmentResponse?
    
    @IBOutlet weak var quantity: UILabel!
    @IBOutlet weak var batchNumber: UILabel!
    @IBOutlet weak var status: UILabel!
    @IBOutlet weak var createdAt: UILabel!
  
    func setupUI(with shipmentData: ShipmentResponse) {
        
        self.quantity.text = String(describing: shipmentData.quantity)
        self.batchNumber.text = String(describing: shipmentData.shipmentNumber)
        self.status.text = shipmentData.status
        self.createdAt.text = shipmentData.createdAt

        if shipmentData.status == "new" {
            self.status.backgroundColor = .green
        } else if shipmentData.status == "retailed" {
            self.status.backgroundColor = .orange
        } else if shipmentData.status == "deliverd" {
            self.status.backgroundColor = .brown
        } else if shipmentData.status == "refused" {
            self.status.backgroundColor = .systemYellow
        } else if shipmentData.status == "recived" {
            self.status.backgroundColor = .lightGray
        }
    }
}
