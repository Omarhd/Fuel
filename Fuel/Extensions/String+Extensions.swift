//
//  String+Extensions.swift
//  Yummie
//
//  Created by Omar on 25/11/2021.
//

import Foundation

extension String {
    var asUrl: URL? {
        return URL(string: self)
    }
    
    var isNotEmpty: Bool {
        return !isEmpty
    }
}


