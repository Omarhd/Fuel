//
//  RetailShipmentPresenter.swift
//  Fuel
//
//  Created by Omar Abdulrahman on 3/14/22.
//

import Foundation
import Alamofire


protocol RetailShipmentDelegate: NSObjectProtocol {
    func startLoading()
    func stopLoading()
    func didRecevidShimentResponse(_ shipmentRespons: RetailsShipmentResponse)
    func didReceivedError(_ message: String)
}

class RetailShipmentPresenter {
    fileprivate let retailShipmentClient: APiServicesClient
    weak fileprivate var retailShipmentView: RetailShipmentDelegate?
    
    init(retailShipmentClient: APiServicesClient) {
        self.retailShipmentClient = retailShipmentClient
    }
    
    func attachView(_ view: RetailShipmentDelegate) {
        self.retailShipmentView = view
    }
    
    func detachView() {
        self.retailShipmentView = nil
    }
    
    func retailingShipment(params: [String: Any]) {
        self.retailShipmentView?.startLoading()
        AF.request("http://192.168.8.100:8000/retailShipments/retailShipment",
                   method: .post,
                   parameters: params).response { response in
            debugPrint(response)
            switch response.result {
            case .success(let data):
                print(data)
                if data != nil {
                let data = try? JSONDecoder().decode(RetailsShipmentResponse.self, from: data!)
                self.retailShipmentView?.didRecevidShimentResponse(data!)
                self.retailShipmentView?.stopLoading()
                showMessage(title: "Shipment Retailed", body: "Successfully Retailing shipment.", type: .success, icon: .default)
                }
                else {
                    showMessage(title: "Shipment Retailed", body: "Successfully Retailing shipment.", type: .info, icon: .default)
                }
            case .failure(_):
                self.retailShipmentView?.stopLoading()
                showMessage(title: "Error", body: "Unkown Error", type: .error, icon: .default)
            }
        }
    }
    
    func retailingShipments(shipmentID: String, qt: Int) {
        self.retailShipmentView?.startLoading()
        
        self.retailShipmentClient.retailShipment(shimentID: shipmentID, agentID: UserDefaults.standard.hasID, qt: qt) { [weak self] result in
            switch result {
            case .success(let data):
                
                self?.retailShipmentView?.didRecevidShimentResponse(data)
                self?.retailShipmentView?.stopLoading()
                
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
                self?.retailShipmentView?.stopLoading()
                self?.retailShipmentView?.didReceivedError(messageToShow)
            }
        }
    }
    
}
