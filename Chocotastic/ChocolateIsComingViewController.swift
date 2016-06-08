//
//  ChocolateIsComingViewController.swift
//  Chocotastic
//
//  Created by Ellen Shapiro on 6/7/16.
//  Copyright © 2016 RayWenderlich.com. All rights reserved.
//

import UIKit

class ChocolateIsComingViewController: UIViewController {
  
  @IBOutlet var orderLabel: UILabel!
  @IBOutlet var costLabel: UILabel!
  @IBOutlet var creditCardIcon: UIImageView!
  
  var cardType: CardType = .Unknown {
    didSet {
      configureIconForCardType()
    }
  }
  
  //MARK: - View lifecycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    configureIconForCardType()
    configureLabelsFromCart()
  }
  
  
  //MARK: - Configuration methods
  
  private func configureIconForCardType() {
    guard let imageView = creditCardIcon else {
      //View hasn't loaded yet, come back later.
      return
    }
    
    imageView.image = cardType.image
  }
  
  private func configureLabelsFromCart() {
    guard let costLabel = costLabel else {
      //View hasn't loaded yet, come back later.
      return
    }
    
    let cart = ShoppingCart.sharedCart
    
    costLabel.text = CurrencyFormatter.dollarsFormatter.stringFromNumber(cart.totalCost())
    
    orderLabel.text = cart.itemCountString()
  }
}
