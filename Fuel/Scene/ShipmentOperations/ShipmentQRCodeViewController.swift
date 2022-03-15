//
//  ShipmentQRCodeViewController.swift
//  Fuel Admin
//
//  Created by Omar Abdulrahman on 3/1/22.
//

import UIKit
import ProgressHUD
import Alamofire

class ShipmentQRCodeViewController: UIViewController {

    @IBOutlet weak var shipmentQuantity: UILabel!
    @IBOutlet weak var shipmentBatchNumber: UILabel!
    @IBOutlet weak var createdAt: UILabel!
    @IBOutlet weak var ShipmentStatus: UILabel!
    
    @IBOutlet weak var acceptButton: UIButton!
    @IBOutlet weak var refuseButton: UIButton!
    @IBOutlet weak var detailsStackView: UIStackView!
    
    var shipmentData: ShipmentResponse?
    var agentData: AgentModel?
    var shipmentID: String?
    
    // MARK:- View presenter
    fileprivate let shipmentDetailsPresnter = ShipmentDetailsPresenter(shipmentDetailsClient: APiServicesClient())

    override func viewDidLoad() {
        super.viewDidLoad()

        self.shipmentDetailsPresnter.attachView(self)
        
        let shipmentID = self.shipmentID
        self.shipmentDetailsPresnter.getShipment(shipmentID: shipmentID!)
               
    }
    
    @IBAction func acceptClicked(_ sender: Any) {
        
        self.shipmentDetailsPresnter.acceptActionOnShipment(shipmentID: shipmentData!.id)
//        actionOnShipment(endPoint: "http://192.168.8.100:8000/shipments/shipment/holder", shipmentID: shipmentData!.id)
    }
    
    @IBAction func refuseClicked(_ sender: Any) {
        self.shipmentDetailsPresnter.refuseActionOnShipment(shipmentID: shipmentData!.id)
//        actionOnShipment(endPoint: "http://192.168.8.100:8000/shipments/shipment/refuse", shipmentID: shipmentData!.id)

    }
    
    
    func actionOnShipment(endPoint: String, shipmentID: String) {
        
        let params = ["shipment_id": shipmentID,"user_id": UserDefaults.standard.hasID]
        
        AF.request(endPoint,
                   method: .patch,
                   parameters: params,
                   encoder: JSONParameterEncoder.default).response { response in
//            debugPrint(response)
                       
            switch response.result {
                
            case .success(_):
                showMessage(title: "Shipment Accepted", body: "Successfully Accepted Shipment", type: .success, icon: .default)
                self.navigationController?.popToRootViewController(animated: true)
            case .failure(_):
                showMessage(title: "Error", body: "Unkown Error", type: .error, icon: .default)
                self.navigationController?.popToRootViewController(animated: true)
            }
        }
    }
    
    fileprivate func SetUPShipmentUI(with shipmentData: ShipmentResponse) {
      
        shipmentQuantity.text = String(describing: shipmentData.quantity)
        shipmentBatchNumber.text = String(describing: shipmentData.shipmentNumber)
        ShipmentStatus.text = shipmentData.status
        createdAt.text = shipmentData.createdAt
        
        if shipmentData.status == "refused" {
            acceptButton.isHidden = true
            refuseButton.isHidden = true
            self.shipmentDetailsPresnter.getAgent(agentID: shipmentData.currentHolder!)

        } else if shipmentData.status == "sold" {
            acceptButton.isHidden = true
            refuseButton.isHidden = true
            self.shipmentDetailsPresnter.getAgent(agentID: shipmentData.currentHolder!)

        } else if shipmentData.status == "recived" {
            acceptButton.isHidden = true
            refuseButton.isHidden = true
            self.shipmentDetailsPresnter.getAgent(agentID: shipmentData.currentHolder!)

        } else {
            acceptButton.isHidden = false
            refuseButton.isHidden = false
        }
    }
}

extension ShipmentQRCodeViewController: ShipmentDetailsDelegate {
   
    func didRecivedAgentData(_ agentData: AgentModel) {
        self.detailsStackView.isHidden = false
    }
    
   
    func acceptedData(_ data: ChangeShipmentHolderResponse) {
        if data.status == "" {
            showMessage(title: "Shipment Accepted", body: "success", type: .success, icon: .light)
            
            navigationController?.popToRootViewController(animated: true)
        }
    }
    
    func refusedData(_ data: ChangeShipmentHolderResponse) {
        if data.status == "refused" {
            navigationController?.popToRootViewController(animated: true)
        }
        
        if data.status == "recived" {
            let qrCodeShipmentVC = ShipmentQrDetailsViewController.instantiate()
            qrCodeShipmentVC.shipmentDetails = self.shipmentData
            UserDefaults.standard.hasShipmentID = shipmentData!.id

            navigationController?.pushViewController(qrCodeShipmentVC, animated: true)
        }
    }
    
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
