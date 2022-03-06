//
//  AuthenticationClient.swift
//  Fuel Admin
//
//  Created by Omar Abdulrahman on 2/28/22.
//

import Foundation
class AuthenticationClient: APIClient {
    internal let session: URLSession
    
    init(configuration: URLSessionConfiguration) {
        self.session = URLSession(configuration: configuration)
    }
    
    convenience init() {
        self.init(configuration: .default)
    }
    
    func authRequest(nationalNumber: String,
                     password: String,
                     completion: @escaping (Result<LoginResponse, DataLayerError<ErrorModel>>) -> Void) {
        let parameters = LoginRequest(nationalNumber: nationalNumber, password: password)
        guard let request = AuthenticationFeed.UsersLogin.postRequest(parameters: parameters, headers: [HTTPHeader.contentType("application/json")]) else { return }
        print("REquest \(request)")
        print("Parameters \(parameters)")
        
        fetchHandler(with: request, decode: { (json) -> LoginResponse? in
            guard let result = json as? LoginResponse else {return nil}
            return result
        }, completion: completion)
    }
}
