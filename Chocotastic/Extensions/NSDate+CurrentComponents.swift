//
//  NSDate+CurrentComponents.swift
//  Chocotastic
//
//  Created by Ellen Shapiro on 6/7/16.
//  Copyright © 2016 RayWenderlich.com. All rights reserved.
//

import Foundation

extension NSDate {
  
  static func rw_gregorianCalendar() -> NSCalendar {
    //All the years we're dealing with are in the gregorian calendar, so use that in case the system calendar is different.
    guard let calendar = NSCalendar(calendarIdentifier: NSCalendarIdentifierGregorian) else {
      fatalError("Couldn't instantiate gregorian calendar?!")
    }
    
    return calendar
  }
  
  func rw_currentYear() -> Int {
    return NSDate
      .rw_gregorianCalendar()
      .component(.Year, fromDate: self)
  }
  
  func rw_currentMonth() -> Int {
    return NSDate
      .rw_gregorianCalendar()
      .component(.Month, fromDate: self)
  }
}
