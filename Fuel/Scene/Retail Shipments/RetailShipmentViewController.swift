//
//  RetailShipmentViewController.swift
//  Fuel
//
//  Created by Omar Abdulrahman on 3/14/22.
//

import UIKit

class RetailShipmentViewController: UIViewController {

    @IBOutlet weak var shipmentQuantity: UILabel!
    @IBOutlet weak var shipmentBatchNumber: UILabel!
    @IBOutlet weak var createdAt: UILabel!
    @IBOutlet weak var ShipmentStatus: UILabel!

    @IBOutlet weak var quantityForRetails: UITextField!
    
    var shipmentDetails: ShipmentResponse!
    
    // MARK:- View presenter
    fileprivate let retailsShipmentPresenter = RetailShipmentPresenter(retailShipmentClient: APiServicesClient())

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.retailsShipmentPresenter.attachView(self)
        

        shipmentQuantity.text = String(describing: shipmentDetails.quantity)
        shipmentBatchNumber.text = String(describing: shipmentDetails.shipmentNumber)
        ShipmentStatus.text = shipmentDetails.status
        createdAt.text = shipmentDetails.createdAt
        
    }
    
    @IBAction func retailsAction(_ sender: Any) {
        guard let qt = quantityForRetails.text, qt.isNotEmpty else { return }
        
        let params: [String: Any] = ["shipment_id": shipmentDetails.id, "agent_id": UserDefaults.standard.hasID, "quantity": Int(qt)!]
        
        self.retailsShipmentPresenter.retailingShipment(params: params)
    }
}

extension RetailShipmentViewController: RetailShipmentDelegate {
   
    func startLoading() {
        
    }
    
    func stopLoading() {
        
    }
    
    func didRecevidShimentResponse(_ shipmentRespons: RetailsShipmentResponse) {
        showMessage(title: "Done", body: "Retailing Success", type: .success, icon: .default)
        navigationController?.popToRootViewController(animated: true)
    }
    
    func didReceivedError(_ message: String) {
        
    }
}
