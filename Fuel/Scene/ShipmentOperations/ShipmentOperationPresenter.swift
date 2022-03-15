//
//  ShipmentDetailsPresenter.swift
//  Fuel Admin
//
//  Created by Omar Abdulrahman on 3/2/22.
//

import Foundation
import UIKit
import Alamofire

protocol ShipmentDetailsDelegate: NSObjectProtocol {
    func startLoading()
    func stopLoading()
    func didRecevidShimentResponse(_ shipmentRespons: ShipmentResponse)
    func acceptedData(_ data: ChangeShipmentHolderResponse)
    func refusedData(_ data: ChangeShipmentHolderResponse)
    func didRecivedAgentData(_ agentData: AgentModel)
    func didReceivedError(_ message: String)
}

class ShipmentDetailsPresenter {
    fileprivate let shipmentDetailsClient: APiServicesClient
    weak fileprivate var shipmenDetailstView: ShipmentDetailsDelegate?
    
    init(shipmentDetailsClient: APiServicesClient) {
        self.shipmentDetailsClient = shipmentDetailsClient
    }
    
    func attachView(_ view: ShipmentDetailsDelegate) {
        self.shipmenDetailstView = view
    }
    
    func detachView() {
        self.shipmenDetailstView = nil
    }
    
    func getShipment(shipmentID: String) {
        self.shipmenDetailstView?.startLoading()
        self.shipmentDetailsClient.getLastShipment(shipmentID: shipmentID) { [weak self] result in
            switch result {
            case .success(let data):
                
                self?.shipmenDetailstView?.didRecevidShimentResponse(data)
                self?.shipmenDetailstView?.stopLoading()
                
            case .failure(let error):
                var messageToShow = ""
                switch error {
                case .backend(let backendError):
                    messageToShow = backendError.message!
                case .network(let message):
                    messageToShow = message
                case .parsing(let errorDesc, let statusCode):
                    messageToShow = "Reciverd Error"
                    print("status Code \(statusCode)")
                    print("Error Dec \(errorDesc)")
                }
                self?.shipmenDetailstView?.stopLoading()
                self?.shipmenDetailstView?.didReceivedError(messageToShow)
            }
        }
    }
    
    func getAgent(agentID: String) {
        self.shipmenDetailstView?.startLoading()
        self.shipmentDetailsClient.getAgentByID(agentID: agentID) { [weak self] result in
            switch result {
            case .success(let data):
                self?.shipmenDetailstView?.didRecivedAgentData(data)
                self?.shipmenDetailstView?.stopLoading()
                
            case .failure(let error):
                var messageToShow = ""
                switch error {
                case .backend(let backendError):
                    messageToShow = backendError.message!
                case .network(let message):
                    messageToShow = message
                case .parsing(let errorDesc, let statusCode):
                    messageToShow = "Reciverd Error"
                    print("status Code \(statusCode)")
                    print("Error Dec \(errorDesc)")
                }
                self?.shipmenDetailstView?.stopLoading()
                self?.shipmenDetailstView?.didReceivedError(messageToShow)
            }
        }
    }
    
    func acceptShipment(shipmentID: String) {
        self.shipmenDetailstView?.startLoading()
        self.shipmentDetailsClient.acceptShipment(shipmentID: shipmentID) { [weak self] result in
            switch result {
            case .success(let data):
                
                self?.shipmenDetailstView?.acceptedData(data)
                self?.shipmenDetailstView?.stopLoading()
                
            case .failure(let error):
                var messageToShow = ""
                switch error {
                case .backend(let backendError):
                    messageToShow = backendError.message!
                case .network(let message):
                    messageToShow = message
                case .parsing(let errorDesc, let statusCode):
                    messageToShow = "Reciverd Error"
                    print("status Code \(statusCode)")
                    print("Error Dec \(errorDesc)")
                }
                self?.shipmenDetailstView?.stopLoading()
                self?.shipmenDetailstView?.didReceivedError(messageToShow)
            }
        }
    }
    
    
    func acceptActionOnShipment(shipmentID: String) {
        let params = ["shipment_id": shipmentID,"user_id": UserDefaults.standard.hasID]
        AF.request("http://192.168.8.100:8000/shipments/shipment/holder",
                   method: .patch,
                   parameters: params,
                   encoder: JSONParameterEncoder.default).response { response in
            debugPrint(response)
            switch response.result {
            case .success(let data):
                let refusedData = try? JSONDecoder().decode(ChangeShipmentHolderResponse.self, from: data!)
                showMessage(title: "Shipment Accepted", body: "Successfully Accept Shipment", type: .success, icon: .default)
                self.shipmenDetailstView?.refusedData(refusedData!)
            case .failure(_):
                showMessage(title: "Error", body: "Unkown Error", type: .error, icon: .default)
            }
        }
    }
    
    func refuseActionOnShipment(shipmentID: String) {
        let params = ["shipment_id": shipmentID,"user_id": UserDefaults.standard.hasID]
        AF.request("http://192.168.8.100:8000/shipments/shipment/refuse",
                   method: .patch,
                   parameters: params,
                   encoder: JSONParameterEncoder.default).response { response in
            debugPrint(response)
            switch response.result {
            case .success(let data):
                let refusedData = try? JSONDecoder().decode(ChangeShipmentHolderResponse.self, from: data!)
                showMessage(title: "Shipment Refused", body: "Successfully Refused Shipment", type: .success, icon: .default)
                self.shipmenDetailstView?.refusedData(refusedData!)
            case .failure(_):
                showMessage(title: "Error", body: "Unkown Error", type: .error, icon: .default)
            }
        }
    }
//    func rejectShipments(shipmentID: String) {
//        self.shipmenDetailstView?.startLoading()
//        self.shipmentDetailsClient.rejectShipment(shipmentID: shipmentID)
//        self.shipmenDetailstView?.stopLoading()
//
//    }
//
//    func acceptShipments(shipmentID: String) {
//        self.shipmenDetailstView?.startLoading()
//        self.shipmentDetailsClient.acceptShipment(shipmentID: shipmentID)
//        self.shipmenDetailstView?.stopLoading()
//
//    }
    
    func refuseShipment(shipmentID: String) {
        self.shipmenDetailstView?.startLoading()
        self.shipmentDetailsClient.refuseShipment(shipmentID: shipmentID) { [weak self] result in
            switch result {
            case .success(let data):
                
                self?.shipmenDetailstView?.refusedData(data)
                self?.shipmenDetailstView?.stopLoading()
                
            case .failure(let error):
                var messageToShow = ""
                switch error {
                case .backend(let backendError):
                    messageToShow = backendError.message!
                case .network(let message):
                    messageToShow = message
                case .parsing(let errorDesc, let statusCode):
                    messageToShow = "Reciverd Error"
                    print("status Code \(statusCode)")
                    print("Error Dec \(errorDesc)")
                }
                self?.shipmenDetailstView?.stopLoading()
                self?.shipmenDetailstView?.didReceivedError(messageToShow)
            }
        }
    }
    
}
