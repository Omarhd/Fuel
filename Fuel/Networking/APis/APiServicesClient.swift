//
//  APiServices.swift
//  Fuel Admin
//
//  Created by Omar Abdulrahman on 2/28/22.
//

import Foundation

class APiServicesClient: APIClient {
    
    internal let session: URLSession
    
    init(configuration: URLSessionConfiguration) {
        self.session = URLSession(configuration: configuration)
    }
    
    convenience init() {
        self.init(configuration: .default)
    }
    
//    func createShipment(shimentBatchNumber: Int,
//                        shipmentQuantity: Int,
//                        completion: @escaping (Result<ShipmentResponse, DataLayerError<ErrorModel>>) -> Void) {
//       
//        let adminID = UserDefaults.standard.hasID
//        let parameters = CreateShipmentRequest(adminID: adminID, shipmentBatchNumber: shimentBatchNumber, shipmentQuantity: shipmentQuantity)
//        
//        let token = UserDefaults.standard.hasToken
//        
//        guard let request = ServicesFeed.createShipments.postRequest(parameters: parameters, headers: [HTTPHeader.contentType("application/json"),
//                                                                                                     HTTPHeader.Authorization(token)]) else { return }
//        print("REquest \(request)")
//        print("Parameters \(parameters)")
//        
//        fetchHandler(with: request, decode: { (json) -> ShipmentResponse? in
//            guard let result = json as? ShipmentResponse else {return nil}
//            return result
//        }, completion: completion)
//    }
//    
//    func getAllShipments(completion: @escaping (Result<[ShipmentResponse], DataLayerError<ErrorModel>>) -> Void) {
//               
//        let token = UserDefaults.standard.hasToken
//        
//        guard let request = ServicesFeed.getAllShipments.getRequest(parameters: ["":""], headers: [HTTPHeader.contentType("application/json"),
//                                                                                                     HTTPHeader.Authorization(token)]) else { return }
//        print("REquest \(request)")
//        
//        fetchHandler(with: request, decode: { (json) -> [ShipmentResponse]? in
//            guard let result = json as? [ShipmentResponse] else {return nil}
//            return result
//        }, completion: completion)
//    }
//    
    func getLastShipment(shipmentID: String, completion: @escaping (Result<ShipmentResponse, DataLayerError<ErrorModel>>) -> Void) {
               
//        let token = UserDefaults.standard.hasToken
        
        guard let request = ServicesFeed.getLastShipment(shipmentID).getRequest(parameters: ["":""], headers: [HTTPHeader.contentType("application/json"),
                                                                                                     HTTPHeader.Authorization("token")]) else { return }
        print("REquest \(request)")
        
        fetchHandler(with: request, decode: { (json) -> ShipmentResponse? in
            guard let result = json as? ShipmentResponse else {return nil}
            return result
        }, completion: completion)
    }
    
    
    
    
//    func createUser(firstNAme: String,
//                    lastName: String,
//                    email: String,
//                    password: String,
//                    phone: String,
//                    nationalID: String,
//                    userType: String,
//                    completion: @escaping (Result<CreateUserResponse, DataLayerError<ErrorModel>>) -> Void) {
//       
//        let adminID = UserDefaults.standard.hasID
//        let token = UserDefaults.standard.hasToken
//        
//        let parameters = CreateUserRequest(firstName: firstNAme, lastName: lastName, email: email, password: password, phoneNumber: phone, nationalNumber: nationalID, createdBy: adminID, userType: userType)
//                
//        guard let request = ServicesFeed.createUsers.postRequest(parameters: parameters, headers: [HTTPHeader.contentType("application/json"),
//                                                                                                     HTTPHeader.Authorization(token)]) else { return }
//        print("REquest \(request)")
//        print("Parameters \(parameters)")
//        
//        fetchHandler(with: request, decode: { (json) -> CreateUserResponse? in
//            guard let result = json as? CreateUserResponse else {return nil}
//            return result
//        }, completion: completion)
//    }
//    
    func acceptShipment(shipmentID: String,
                        completion: @escaping (Result<ChangeShipmentHolderResponse, DataLayerError<ErrorModel>>) -> Void) {
       
        let userID = UserDefaults.standard.hasID
        let token = UserDefaults.standard.hasToken
        
        let parameters = ChangeShipmentHolder(shipmentID: shipmentID, userID: userID)
                
        guard let request = ServicesFeed.updateUser.patchRequest(parameters: parameters, headers: [HTTPHeader.contentType("application/json"),
                                                                                                     HTTPHeader.Authorization(token)]) else { return }
        print("REquest \(request)")
        print("Parameters \(parameters)")
        
        fetchHandler(with: request, decode: { (json) -> ChangeShipmentHolderResponse? in
            guard let result = json as? ChangeShipmentHolderResponse else {return nil}
            return result
        }, completion: completion)
    }
//    
//    func deleteUser(userID: String, completion: @escaping(Result<Bool, DataLayerError<ErrorModel>>) -> Void)  {
//
//       
//        let token = UserDefaults.standard.hasToken
//                        
//        guard let request = ServicesFeed.deleteUser(userID).deleteRequest(parameters: ["":""], headers: [HTTPHeader.contentType("application/json"),
//                                                                                                     HTTPHeader.Authorization(token)]) else { return }
//        print("REquest \(request)")
////        print("Parameters \(parameters)")
//        
//        fetchHandlerWithoutResponse(with: request, completion: completion)
//    }
//    
//    func getAllUsers(completion: @escaping (Result<[AllUsers], DataLayerError<ErrorModel>>) -> Void) {
//               
//        let token = UserDefaults.standard.hasToken
//        
//        guard let request = ServicesFeed.getAllUsers.getRequest(parameters: ["":""], headers: [HTTPHeader.contentType("application/json"),
//                                                                                                     HTTPHeader.Authorization(token)]) else { return }
//        print("REquest \(request)")
//        
//        fetchHandler(with: request, decode: { (json) -> [AllUsers]? in
//            guard let result = json as? [AllUsers] else {return nil}
//            return result
//        }, completion: completion)
//    }
//    
//    func getAllOperations(completion: @escaping (Result<[Operations], DataLayerError<ErrorModel>>) -> Void) {
//               
//        let token = UserDefaults.standard.hasToken
//        
//        guard let request = ServicesFeed.getOperations.getRequest(parameters: ["":""], headers: [HTTPHeader.contentType("application/json"),
//                                                                                                     HTTPHeader.Authorization(token)]) else { return }
//        print("REquest \(request)")
//        
//        fetchHandler(with: request, decode: { (json) -> [Operations]? in
//            guard let result = json as? [Operations] else {return nil}
//            return result
//        }, completion: completion)
//    }
}
