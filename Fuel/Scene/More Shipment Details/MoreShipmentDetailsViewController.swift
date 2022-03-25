//
//  MoreShipmentDetailsViewController.swift
//  Fuel
//
//  Created by Omar Abdulrahman on 3/22/22.
//

import UIKit

class MoreShipmentDetailsViewController: UIViewController {

    var shipmentDetails: ShipmentResponse?
    var userData: GetUserResponse?
    
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var nationalIDLbl: UILabel!
    @IBOutlet weak var typeLbl: UILabel!
    @IBOutlet weak var phoneLbl: UILabel!
 
    override func viewDidLoad() {
        super.viewDidLoad()

        print(userData, shipmentDetails)
        
        nameLbl.text = userData?.firstName
        nationalIDLbl.text = userData?.nationalNumber
        typeLbl.text = userData?.type
        phoneLbl.text = userData?.phoneNumber
        
    }
}
