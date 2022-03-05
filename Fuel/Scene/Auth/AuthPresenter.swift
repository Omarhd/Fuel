//
//  AuthPresenter.swift
//  ZFuel Admin
//
//  Created by Omar Abdulrahman on 2/23/22.
//

import Foundation

protocol AuthViewDelegate: NSObjectProtocol {
    func startLoading()
    func stopLoading()
    func didRecevidToken(_ token: String, _ userID: String)
    func didReceivedError(_ message: String)
}

class AuthPresenter {
    fileprivate let authenticationClient: AuthenticationClient
    weak fileprivate var loginView: AuthViewDelegate?
    
    init(authenticationClient: AuthenticationClient) {
        self.authenticationClient = authenticationClient
    }
    
    func attachView(_ view: AuthViewDelegate) {
        self.loginView = view
    }
    
    func detachView() {
        self.loginView = nil
    }
    
    func loginRequest(nationalNumber: String, password: String) {
        self.loginView?.startLoading()
        self.authenticationClient.authRequest(nationalNumber: nationalNumber, password: password) { [weak self] result in
            switch result {
            case .success(let data):
                let token =  data.token
                let userID = data.ID
                self?.loginView?.didRecevidToken(token, userID)
                self?.loginView?.stopLoading()
                
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
                self?.loginView?.stopLoading()
                self?.loginView?.didReceivedError(messageToShow)
            }
        }
    }
}

