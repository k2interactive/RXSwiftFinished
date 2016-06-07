//
//  ChocolateCell.swift
//  Chocotastic
//
//  Created by Ellen Shapiro on 6/5/16.
//  Copyright © 2016 RayWenderlich.com. All rights reserved.
//

import UIKit

class ChocolateCell: UITableViewCell {
    
    static let Identifier = "ChocolateCell"
    
    @IBOutlet private var countryNameLabel: UILabel!
    @IBOutlet private var emojiLabel: UILabel!
    @IBOutlet private var priceLabel: UILabel!
    @IBOutlet private var addButton: UIButton!
    
    func configureWithChocolate(chocolate: Chocolate) {
        countryNameLabel.text = chocolate.countryName
        emojiLabel.text = "🍫" + chocolate.countryFlagEmoji
        priceLabel.text = CurrencyFormatter.dollarsFormatter.stringFromNumber(chocolate.priceInDollars)
    }
}
