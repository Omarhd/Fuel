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
                let data = try? JSONDecoder().decode(RetailsShipmentResponse.self, from: data!)
                DispatchQueue.main.async {
                    self.retailShipmentView?.didRecevidShimentResponse(data!)
                    self.retailShipmentView?.stopLoading()
                    showMessage(title: "Shipment Retailed", body: "Successfully Updated Success.", type: .success, icon: .default)

                }
            case .failure(_):
                self.retailShipmentView?.stopLoading()
                showMessage(title: "Error", body: "Unkown Error", type: .error, icon: .default)
            }
        }
    }
    
}
