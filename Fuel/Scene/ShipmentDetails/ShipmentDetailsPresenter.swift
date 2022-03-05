//
//  ShipmentDetailsPresenter.swift
//  Fuel Admin
//
//  Created by Omar Abdulrahman on 3/2/22.
//

import Foundation

protocol ShipmentDetailsDelegate: NSObjectProtocol {
    func startLoading()
    func stopLoading()
    func didRecevidShimentResponse(_ shipmentRespons: ShipmentResponse)
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
    
}
