//
//  AutoFormatter.swift
//  Chocotastic
//
//  Created by Ellen Shapiro on 6/6/16.
//  Copyright © 2016 RayWenderlich.com. All rights reserved.
//

import Foundation

protocol AutoFormatter {
    
    static func format(string: String) -> String
}

struct CreditCardFormatter: AutoFormatter {
    
    static func format(string: String) -> String {
        
    }
    
}
