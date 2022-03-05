//
//  CardView.swift
//  Yummie
//
//  Created by Omar on 25/11/2021.
//

import UIKit

class CardView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        initailSetup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        initailSetup()
    }
    
    private func initailSetup() {
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = .zero
        layer.shadowOpacity = 0.2
        layer.cornerRadius = 10
        layer.shadowRadius = 10
        
        cornerRedius = 10
    }
}
