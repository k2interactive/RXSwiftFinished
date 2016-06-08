//
//  ImageName.swift
//  Chocotastic
//
//  Created by Ellen Shapiro on 6/7/16.
//  Copyright © 2016 RayWenderlich.com. All rights reserved.
//

import UIKit

enum ImageName: String {
  case
  Amex,
  Discover,
  Mastercard,
  Visa,
  UnknownCard
  
  var image: UIImage {
    guard let image = UIImage(named: self.rawValue) else {
      fatalError("Image not found for name \(self.rawValue)")
    }
    
    return image
  }
}
