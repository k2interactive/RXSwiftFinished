//
//  ValidatingTextField.swift
//  Chocotastic
//
//  Created by Ellen Shapiro on 6/7/16.
//  Copyright © 2016 RayWenderlich.com. All rights reserved.
//

import UIKit

class ValidatingTextField: UITextField {

    var valid: Bool = false {
        didSet {
            configureForValid()
        }
    }
    
    var hasBeenExited: Bool = false {
        didSet {
            configureForValid()
        }
    }
    
    func commonInit() {
        configureForValid()
    }
    
    //Yeah, totally required.
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func resignFirstResponder() -> Bool {
        hasBeenExited = true
        return super.resignFirstResponder()
    }
    
    private func configureForValid() {
        if !valid && hasBeenExited {
            //Only color the background if the user has tried to
            //input things at least once. 
            self.backgroundColor = .redColor()
        } else {
            self.backgroundColor = .clearColor()
        }
    }
}

