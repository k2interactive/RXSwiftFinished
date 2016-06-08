//
//  ChocolateButton.swift
//  Chocotastic
//
//  Created by Ellen Shapiro on 6/7/16.
//  Copyright © 2016 RayWenderlich.com. All rights reserved.
//

import UIKit

@IBDesignable
class ChocolateButton: UIButton {
  
  override var enabled: Bool {
    didSet {
      if self.enabled {
        self.alpha = 1
      } else {
        self.alpha = 0.5
      }
    }
  }
  
  enum Type {
    case
    Standard,
    Warning
  }
  
  ///Workaround for enum values not being IBInspectable.
  @IBInspectable var isStandard: Bool = false {
    didSet {
      if isStandard {
        type = .Standard
      } else {
        type = .Warning
      }
    }
  }
  
  
  private var type: Type = .Standard {
    didSet {
      updateBackgroundColorForCurrentType()
    }
  }
  
  
  //MARK: Initialization
  
  private func commonInit() {
    self.setTitleColor(.whiteColor(), forState: .Normal)
    updateBackgroundColorForCurrentType()
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    commonInit()
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    commonInit()
  }
  
  override func prepareForInterfaceBuilder() {
    super.prepareForInterfaceBuilder()
    commonInit()
  }
  
  func updateBackgroundColorForCurrentType() {
    switch type {
    case .Standard:
      self.backgroundColor = .brownColor()
    case .Warning:
      self.backgroundColor = .redColor()
    }
  }
}
