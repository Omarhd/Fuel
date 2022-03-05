//
//  Custom Messgaes.swift
//  Fuel Admin
//
//  Created by Omar Abdulrahman on 3/1/22.
//

import UIKit
import SwiftMessages

func showTopNotificaionForGoodNetwork(title : String, body : String) {
    
    let view = MessageView.viewFromNib(layout: .statusLine)
    view.configureTheme(.success)
    view.configureDropShadow()
    view.contentMode = .scaleAspectFill
    view.configureContent(title: title, body: body)
    view.configureTheme(.success, iconStyle: .default)
    view.layoutMarginAdditions = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    view.button?.isHidden = true
    (view.backgroundView as? CornerRoundingView)?.cornerRadius = 10
    
    SwiftMessages.show(view: view)
}

func showMessage(title : String, body : String, type: Theme, icon: IconStyle) {
    
    let view = MessageView.viewFromNib(layout: .cardView)
//    view.configureTheme(.success)
    view.configureDropShadow()
    view.contentMode = .scaleAspectFill
    view.configureContent(title: title, body: body)
    view.configureTheme(type, iconStyle: icon)
    view.layoutMarginAdditions = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    view.button?.isHidden = true
    (view.backgroundView as? CornerRoundingView)?.cornerRadius = 10
    
    SwiftMessages.show(view: view)
}


