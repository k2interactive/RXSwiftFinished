//
//  String+ExpirationDate.swift
//  Chocotastic
//
//  Created by Ellen Shapiro on 6/7/16.
//  Copyright © 2016 RayWenderlich.com. All rights reserved.
//

import Foundation

extension String {

    func rw_addSlash() -> String {
        guard self.characters.count > 2 else {
            //Nothing to add
            return self
        }
        
        let index2 = self.startIndex.advancedBy(2)
        let firstTwo = self.substringToIndex(index2)
        let rest = self.substringFromIndex(index2)
        
        return firstTwo + " / " + rest
    }
    
    func rw_removeSlash() -> String {
        let removedSpaces = self.rw_removeSpaces()
        return removedSpaces.stringByReplacingOccurrencesOfString("/", withString: "")
    }
    
    func rw_isValidExpirationDate() -> Bool {
        let noSlash = self.rw_removeSlash()

        guard noSlash.characters.count == 6 //Must be mmyyyy
            && noSlash.rw_allCharactersAreNumbers() else { //must be all numbers
            return false
        }
        
        let index2 = self.startIndex.advancedBy(2)
        let monthString = self.substringToIndex(index2)
        let yearString = self.substringFromIndex(index2)
        
        guard let
            month = Int(monthString),
            year = Int(yearString) else {
                //We can't even check.
                return false
        }
        
        //Month must be between january and december.
        guard (month >= 1 && month <= 12) else {
            return false
        }
        
        let now = NSDate()
        let currentYear = now.rw_currentYear()
        
        guard year >= currentYear else {
            //Year is before current: Not valid.
            return false
        }
        
        if year == currentYear {
            let currentMonth = now.rw_currentMonth()
            guard month >= currentMonth else {
                //Month is before current in current year: Not valid.
                return false
            }
        }

        //If we made it here: Woo!
        return true
    }
}
