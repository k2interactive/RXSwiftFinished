//
//  CreditCardType.swift
//  Chocotastic
//
//  Created by Ellen Shapiro on 6/6/16.
//  Copyright © 2016 RayWenderlich.com. All rights reserved.
//

import Foundation

struct CreditCardType {
    
    enum CardType {
        case
        Unknown,
        Amex,
        Mastercard,
        Visa,
        Discover
        
        static func fromString(string: String) -> CardType {

            
            if string.hasPrefix("4") {
                return .Visa
            }
            
            if string.hasPrefix("5") {
                //510000-559999 are valid mastercards
                let firstTwo = string.substringToIndex(string.characters.startIndex.advancedBy(2))
                if let firstTwoAsNumber = Int(firstTwo) {
                    if firstTwoAsNumber > 51 && firstTwoAsNumber <= 55 {
                        return .Mastercard
                    }
                }
                
                return .Unknown
            }
            
            //Brace yourselves: New valid mastercards are coming
            //https://www.forte.net/blog/mastercard-bin-range-coming/
            if string.hasPrefix("2") {
                //222100 - 272099
                
                let firstSix = string.substringToIndex(string.characters.startIndex.advancedBy(5))
                
                guard let firstSixAsNumber = Int(firstSix) else {
                    return .Unknown
                }
                
            }
            
            
            return .Unknown
        }
        
    }
}
