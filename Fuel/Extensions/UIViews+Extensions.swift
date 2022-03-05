//
//  UIViews+Extensions.swift
//  Yummie
//
//  Created by Omar on 24/11/2021.
//

import UIKit


extension UIView {
    
    @IBInspectable var cornerRedius: CGFloat {
       
        get { return self.cornerRedius }
        
        set { self.layer.cornerRadius = newValue }
    }
}

class CustomTextField: UITextField {
    
    @IBInspectable var inset: CGFloat = 20

       override func textRect(forBounds bounds: CGRect) -> CGRect {
           return bounds.insetBy(dx: inset, dy: inset)
       }

       override func editingRect(forBounds bounds: CGRect) -> CGRect {
           return textRect(forBounds: bounds)
       }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        layer.cornerRadius = 10
       
    }
}

