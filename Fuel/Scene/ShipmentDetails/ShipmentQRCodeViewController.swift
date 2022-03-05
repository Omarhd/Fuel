//
//  ShipmentQRCodeViewController.swift
//  Fuel Admin
//
//  Created by Omar Abdulrahman on 3/1/22.
//

import UIKit
import ProgressHUD

class ShipmentQRCodeViewController: UIViewController {

    @IBOutlet weak var shipmentQuantity: UILabel!
    @IBOutlet weak var shipmentBatchNumber: UILabel!
    @IBOutlet weak var createdAt: UILabel!
    @IBOutlet weak var ShipmentStatus: UILabel!
    
    var shipmentData: ShipmentResponse?
    var shipmentID: String?
    
    // MARK:- View presenter
    fileprivate let shipmentDetailsPresnter = ShipmentDetailsPresenter(shipmentDetailsClient: APiServicesClient())

    override func viewDidLoad() {
        super.viewDidLoad()

        self.shipmentDetailsPresnter.attachView(self)
        
        let shipmentID = self.shipmentID
        self.shipmentDetailsPresnter.getShipment(shipmentID: shipmentID!)
       
    }
    
    fileprivate func SetUPShipmentUI(with shipmentData: ShipmentResponse) {
      
        shipmentQuantity.text = String(describing: shipmentData.quantity)
        shipmentBatchNumber.text = String(describing: shipmentData.adminID)
        ShipmentStatus.text = shipmentData.status
        createdAt.text = shipmentData.createdAt
    }
}

extension ShipmentQRCodeViewController: ShipmentDetailsDelegate {
    func startLoading() {
        ProgressHUD.animationType = .lineScaling
        ProgressHUD.show()
    }
    
    func stopLoading() {
        ProgressHUD.dismiss()
    }
    
    func didRecevidShimentResponse(_ shipmentRespons: ShipmentResponse) {
        self.shipmentData = shipmentRespons
        SetUPShipmentUI(with: shipmentData!)

    }
    
    func didReceivedError(_ message: String) {
        ProgressHUD.animationType = .circleStrokeSpin
        ProgressHUD.show(message, icon: .failed, interaction: false)
        showMessage(title: "Error", body: message, type: .error, icon: .none)
    }
}
