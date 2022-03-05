//
//  ViewController.swift
//  ZFuel Admin
//
//  Created by Omar Abdulrahman on 2/23/22.
//

import UIKit
import ProgressHUD

class AuthViewController: UIViewController {

    @IBOutlet weak var phoneNumberTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
   
    // MARK:- View presenter
    fileprivate let loginPresenter = AuthPresenter(authenticationClient: AuthenticationClient())

    override func viewDidLoad() {
        super.viewDidLoad()
    
        self.loginPresenter.attachView(self)

    }
    
    @IBAction func loginClicked(_ sender: Any) {
        
        guard let nationalID = phoneNumberTextField.text, nationalID.isNotEmpty,
              let password = passwordTextField.text, password.isNotEmpty else {
            
            ProgressHUD.animationType = .circleStrokeSpin
            ProgressHUD.show("Please Fill all fields.", icon: .failed, interaction: false)
            return }
        
        self.loginPresenter.loginRequest(nationalNumber: nationalID, password: password)
                 
    }
}

extension AuthViewController: AuthViewDelegate {
    func startLoading() {
        ProgressHUD.animationType = .lineScaling
        ProgressHUD.show()
    }
    
    func stopLoading() {
        ProgressHUD.dismiss()
    }
    
    func didRecevidToken(_ token: String, _ userID: String) {
        UserDefaults.standard.hasToken = token
        UserDefaults.standard.hasID = userID
        UserDefaults.standard.hasLogedIn = true
        
        navigateToMain(StoryboardName: "Main", IdentifierName: "TabController")
    }
    
    func didReceivedError(_ message: String) {
        ProgressHUD.animationType = .circleStrokeSpin
        ProgressHUD.show(message, icon: .failed, interaction: false)
    }
}
