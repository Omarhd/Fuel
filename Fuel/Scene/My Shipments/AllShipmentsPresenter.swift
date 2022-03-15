//
//  AllShipmentsPresenter.swift
//  Fuel Admin
//
//  Created by Omar Abdulrahman on 3/1/22.
//

import Foundation

protocol AllShipmentsDelegate: NSObjectProtocol {
    func startLoading()
    func stopLoading()
    func didRecevidShimentResponse(_ shipmentRespons: [ShipmentResponse])
    func didRecevidRetaiedShimentResponse(_ retailedShipmentRespons: [RetailsShipmentResponse])
    func didReceivedError(_ message: String)
}

class AllShipmentPresenter {
    fileprivate let allShipmentsClient: APiServicesClient
    weak fileprivate var allShipmentView: AllShipmentsDelegate?
    
    init(allShipmentsClient: APiServicesClient) {
        self.allShipmentsClient = allShipmentsClient
    }
    
    func attachView(_ view: AllShipmentsDelegate) {
        self.allShipmentView = view
    }
    
    func detachView() {
        self.allShipmentView = nil
    }
    
    func getAllShipments(myID: String) {
        self.allShipmentView?.startLoading()
        self.allShipmentsClient.getAllShipments(myID: myID) { [weak self] result in
            switch result {
            case .success(let data):
                
                self?.allShipmentView?.didRecevidShimentResponse(data)
                self?.allShipmentView?.stopLoading()
                
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
                self?.allShipmentView?.stopLoading()
                self?.allShipmentView?.didReceivedError(messageToShow)
            }
        }
    }
    
    func getAllRetailedShipments() {
        self.allShipmentView?.startLoading()
        self.allShipmentsClient.getAllRetaildShipments { [weak self] result in
            switch result {
            case .success(let data):
                
                self?.allShipmentView?.didRecevidRetaiedShimentResponse(data)
                self?.allShipmentView?.stopLoading()
                
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
                self?.allShipmentView?.stopLoading()
                self?.allShipmentView?.didReceivedError(messageToShow)
            }
        }
    }
}
