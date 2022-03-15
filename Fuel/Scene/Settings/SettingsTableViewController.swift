//
//  SettingsTableViewController.swift
//  Fuel Admin
//
//  Created by Omar Abdulrahman on 2/28/22.
//

import UIKit

class SettingsTableViewController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.section == 1 && indexPath.row == 0 {
            
            let alertController = UIAlertController (
                title: "Are You Sure!!",
                message: "Your Account will be save with your all data.",
                preferredStyle: UIAlertController.Style.alert
            )
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (action) in
            }
            let standard = UserDefaults.standard
            let okayAction = UIAlertAction(title: "yes I'm Sure", style: .destructive) { (action) in
                
                let domain = Bundle.main.bundleIdentifier!
                standard.removePersistentDomain(forName: domain)
                standard.synchronize()
                
                self.navigateTo(StoryboardName: "Main", IdentifierName: "AuthNavigation")
            }
            
            alertController.addAction(okayAction)
            alertController.addAction(cancelAction)
            
            self.present(alertController, animated: true) {
                
            }
        }
    }
    
    func navigateTo(StoryboardName: String ,IdentifierName : String) {
        let main = UIStoryboard(name: StoryboardName, bundle: nil).instantiateViewController(withIdentifier: IdentifierName)
        
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let sceneDelegate = windowScene.delegate as? SceneDelegate, let window = sceneDelegate.window {
            window.rootViewController = main
            
            UIView.transition(with: window, duration: 0.5, options: .transitionCrossDissolve, animations: nil, completion: nil)
        }
    }
    
}
