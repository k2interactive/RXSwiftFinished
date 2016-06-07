//
//  ShoppingCart.swift
//  Chocotastic
//
//  Created by Ellen Shapiro on 6/6/16.
//  Copyright © 2016 RayWenderlich.com. All rights reserved.
//

import Foundation
import RxSwift

struct ShoppingCart {
    
    static let sharedCart = ShoppingCart()
    
    //Create the array of chocolates as an Rx Variable so it can be observed.
    let chocolates: Variable<[Chocolate]> = Variable([])
    
    func totalCost() -> Float {
        return chocolates.value.reduce(0) {
            runningTotal, chocolate in
            return runningTotal + chocolate.priceInDollars
        }
    }
}
