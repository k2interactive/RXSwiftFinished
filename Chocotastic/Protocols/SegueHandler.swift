//
//  SegueHandler.swift
//  Chocotastic
//
//  Created by Ellen Shapiro on 6/6/16.
//  Copyright © 2016 RayWenderlich.com. All rights reserved.
//

import UIKit

/*
 Protocol to make sure all segues are handled safely. More on this techinque:
 https://www.natashatherobot.com/protocol-oriented-segue-identifiers-swift/
 */
protocol SegueHandler {
  associatedtype SegueIdentifier: RawRepresentable
}

extension SegueHandler //Default implementation...
  where Self: UIViewController, //for view controllers...
SegueIdentifier.RawValue == String { //who have String segue identifiers.
  
  func performSegueWithIdentifier(identifier: SegueIdentifier, sender: AnyObject? = nil) {
    performSegueWithIdentifier(identifier.rawValue,
                               sender: sender)
  }
  
  func identifierForSegue(segue: UIStoryboardSegue) -> SegueIdentifier {
    guard let
      stringIdentifier = segue.identifier,
      identifier = SegueIdentifier(rawValue: stringIdentifier) else {
        fatalError("Couldn't find identifier for segue!")
    }
    
    return identifier
  }
}
