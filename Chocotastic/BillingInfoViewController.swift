//
//  BillingInfoViewController.swift
//  Chocotastic
//
//  Created by Ellen Shapiro on 6/6/16.
//  Copyright © 2016 RayWenderlich.com. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class BillingInfoViewController: UIViewController {
  
  @IBOutlet private var creditCardNumberTextField: ValidatingTextField!
  @IBOutlet private var creditCardImageView: UIImageView!
  @IBOutlet private var expirationDateTextField: ValidatingTextField!
  @IBOutlet private var cvvTextField: ValidatingTextField!
  @IBOutlet private var purchaseButton: UIButton!
  
  private let cardType: Variable<CardType> = Variable(.Unknown)
  private let disposeBag = DisposeBag()
  private let throttleInterval = 0.1
  
  
  //MARK: - View Lifecycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    title = "💳 Info"
    
    setupCardImageDisplay()
    setupTextChangeHandling()
  }
  
  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    let identifier = identifierForSegue(segue)
    switch identifier {
    case .PurchaseSuccess:
      guard let destination = segue.destinationViewController as? ChocolateIsComingViewController else {
        assertionFailure("Couldn't get chocolate is coming VC!")
        return
      }
      
      destination.cardType = cardType.value
    }
  }
  
  //MARK: - RX Setup
  
  private func setupCardImageDisplay() {
    cardType
      .asObservable()
      .subscribeNext({
        cardType in
        self.creditCardImageView.image = cardType.image
      })
      .addDisposableTo(disposeBag)
  }
  
  private func setupTextChangeHandling() {
    let creditCardValid = creditCardNumberTextField
      .rx_text
      .throttle(throttleInterval, scheduler: MainScheduler.instance)
      .map { self.validateCardTextChange($0) }
    
    creditCardValid
      .subscribeNext { self.creditCardNumberTextField.valid = $0 }
      .addDisposableTo(disposeBag)
    
    let expirationValid = expirationDateTextField
      .rx_text
      .throttle(throttleInterval, scheduler: MainScheduler.instance)
      .map { self.validateExpirationDateTextChange($0) }
    
    expirationValid
      .subscribeNext { self.expirationDateTextField.valid = $0 }
      .addDisposableTo(disposeBag)
    
    let cvvValid = cvvTextField
      .rx_text
      .map { self.validateCVVTextChange($0) }
    
    cvvValid
      .subscribeNext { self.cvvTextField.valid = $0 }
      .addDisposableTo(disposeBag)
    
    let everythingValid = Observable
      .combineLatest(creditCardValid, expirationValid, cvvValid) {
        $0 && $1 && $2 //All must be true
      }
    
    everythingValid
      .bindTo(purchaseButton.rx_enabled)
      .addDisposableTo(disposeBag)
  }
  
  //MARK: - Validation methods
  
  func validateCardTextChange(cardText: String) -> Bool {
    let noWhitespace = cardText.rw_removeSpaces()
    
    updateCardType(noWhitespace)
    formatCardNumber(noWhitespace)
    advanceFromCardNumberIfNecessary(noWhitespace)
    
    guard cardType.value != .Unknown else {
      //Definitely not valid if the type is unknown.
      return false
    }
    
    guard noWhitespace.rw_isLuhnValid() else {
      //Failed luhn validation
      return false
    }
    
    return noWhitespace.characters.count == self.cardType.value.expectedDigits
  }
  
  func validateExpirationDateTextChange(expiration: String) -> Bool {
    let strippedSlashExpiration = expiration.rw_removeSlash()
    
    formatFromExpirationDate(strippedSlashExpiration)
    advanceFromExpirationDateIfNecessary(strippedSlashExpiration)
    
    return strippedSlashExpiration.rw_isValidExpirationDate()
  }
  
  func validateCVVTextChange(cvv: String) -> Bool {
    guard cvv.rw_allCharactersAreNumbers() else {
      //Someone snuck a letter in here.
      return false
    }
    dismissFromCVVIfNecessary(cvv)
    return cvv.characters.count == self.cardType.value.cvvDigits
  }
  
  
  //MARK: Single-serve helper functions
  
  private func updateCardType(noSpacesNumber: String) {
    cardType.value = CardType.fromString(noSpacesNumber)
  }
  
  private func formatCardNumber(noSpacesCardNumber: String) {
    creditCardNumberTextField.text = self.cardType.value.format(noSpacesCardNumber)
  }
  
  func advanceFromCardNumberIfNecessary(noSpacesNumber: String) {
    if noSpacesNumber.characters.count == self.cardType.value.expectedDigits {
      self.expirationDateTextField.becomeFirstResponder()
    }
  }
  
  func formatFromExpirationDate(expirationNoSpacesOrSlash: String) {
    expirationDateTextField.text = expirationNoSpacesOrSlash.rw_addSlash()
  }
  
  func advanceFromExpirationDateIfNecessary(expirationNoSpacesOrSlash: String) {
    if expirationNoSpacesOrSlash.characters.count == 6 { //mmyyyy
      self.cvvTextField.becomeFirstResponder()
    }
  }
  
  func dismissFromCVVIfNecessary(cvv: String) {
    if cvv.characters.count == self.cardType.value.cvvDigits {
      self.cvvTextField.resignFirstResponder()
    }
  }
}

extension BillingInfoViewController: SegueHandler {
  enum SegueIdentifier: String {
    case
    PurchaseSuccess
  }
}
