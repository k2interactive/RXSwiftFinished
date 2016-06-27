//
//  ShoppingCart.swift
//  Chocotastic
//
//  Created by Ellen Shapiro on 6/6/16.
//  Copyright © 2016 RayWenderlich.com. All rights reserved.
//

import Foundation
import RxSwift

class ShoppingCart {
  
  static let sharedCart = ShoppingCart()
  
  //Create the array of chocolates as an Rx Variable so it can be observed.
  let chocolates: Variable<[Chocolate]> = Variable([])
  
  func totalCost() -> Float {
    return chocolates.value.reduce(0) {
      runningTotal, chocolate in
      return runningTotal + chocolate.priceInDollars
    }
  }
  
  func itemCountString() -> String {
    guard chocolates.value.count > 0 else {
      return "🚫🍫"
    }
    
    //Unique the chocolates
    let setOfChocolates = Set<Chocolate>(chocolates.value)
    
    //Check how many of each exists
    let itemStrings: [String] = setOfChocolates.map {
      chocolate in
      let count: Int = chocolates.value.reduce(0) {
        runningTotal, reduceChocolate in
        if chocolate == reduceChocolate {
          return runningTotal + 1
        }
        
        return runningTotal
      }
      
      return "\(chocolate.countryFlagEmoji)🍫: \(count)"
    }
    
    return itemStrings.joinWithSeparator("\n")
  }
  
}
