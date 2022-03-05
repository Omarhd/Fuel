//
//  UIViewController+Extension.swift
//  Yummie
//
//  Created by Omar on 25/11/2021.
//

import UIKit

extension UIViewController {
    
    static var identifire: String {
        return String(describing: self)
    }
    
    static func instantiate() -> Self {
        
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyBoard.instantiateViewController(withIdentifier: identifire) as! Self
        
        return controller
    }
    
    func navigateToMain(StoryboardName: String ,IdentifierName : String) {
           let main = UIStoryboard(name: StoryboardName, bundle: nil).instantiateViewController(withIdentifier: IdentifierName)
           
           if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let sceneDelegate = windowScene.delegate as? SceneDelegate, let window = sceneDelegate.window {
               window.rootViewController = main
               
               UIView.transition(with: window, duration: 0.5, options: .transitionCrossDissolve, animations: nil, completion: nil)
           }
       }
}
