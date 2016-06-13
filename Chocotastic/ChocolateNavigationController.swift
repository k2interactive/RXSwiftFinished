//
//  ChocolateNavigationController.swift
//  Chocotastic
//
//  Created by Ellen Shapiro on 6/12/16.
//  Copyright © 2016 RayWenderlich.com. All rights reserved.
//

import UIKit

/// Mostly dumb subclass to make status bar style work for views embedded in this navigation controller.
class ChocolateNavigationController: UINavigationController {

  override func preferredStatusBarStyle() -> UIStatusBarStyle {
    return .LightContent
  }
}
