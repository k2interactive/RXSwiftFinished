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

    @IBOutlet private var creditCardNumberTextField: UITextField!
    @IBOutlet private var creditCardImageView: UIImageView!
    @IBOutlet private var expirationDateTextField: UITextField!
    @IBOutlet private var cvvTextField: UITextField!
}
