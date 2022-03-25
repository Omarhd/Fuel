//
//  ShipmentDetailsPresenter.swift
//  Fuel Admin
//
//  Created by Omar Abdulrahman on 3/2/22.
//

import Foundation

protocol ShipmentQrDetailsDelegate: NSObjectProtocol {
    func startLoading()
    func stopLoading()
    func didRecevidShimentResponse(_ shipmentRespons: ShipmentResponse)
    func didRecivedAgentData(_ agentData: GetUserResponse)
    func didReceivedError(_ message: String)
}

class ShipmentQrDetailsPresenter {
    fileprivate let shipmentQrDetailsClient: APiServicesClient
    weak fileprivate var shipmenQrDetailstView: ShipmentQrDetailsDelegate?
    
    init(shipmentQrDetailsClient: APiServicesClient) {
        self.shipmentQrDetailsClient = shipmentQrDetailsClient
    }
    
    func attachView(_ view: ShipmentQrDetailsDelegate) {
        self.shipmenQrDetailstView = view
    }
    
    func detachView() {
        self.shipmenQrDetailstView = nil
    }
    
    func getShipment(shipmentID: String) {
//        self.shipmenDetailstView?.startLoading()
        self.shipmentQrDetailsClient.getLastShipment(shipmentID: shipmentID) { [weak self] result in
            switch result {
            case .success(let data):
                
                self?.shipmenQrDetailstView?.didRecevidShimentResponse(data)
                self?.shipmenQrDetailstView?.stopLoading()
                
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
                self?.shipmenQrDetailstView?.stopLoading()
                self?.shipmenQrDetailstView?.didReceivedError(messageToShow)
            }
        }
    }
    
    func getAgent(agentID: String) {
        self.shipmenQrDetailstView?.startLoading()
        self.shipmentQrDetailsClient.getUserByID(UserID: agentID) { [weak self] result in
            switch result {
            case .success(let data):
                self?.shipmenQrDetailstView?.didRecivedAgentData(data)
                self?.shipmenQrDetailstView?.stopLoading()

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
                self?.shipmenQrDetailstView?.stopLoading()
                self?.shipmenQrDetailstView?.didReceivedError(messageToShow)
            }
        }
    }
}
