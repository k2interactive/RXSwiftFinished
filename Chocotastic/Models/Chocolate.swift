//
//  Chocolate.swift
//  Chocotastic
//
//  Created by Ellen Shapiro on 6/5/16.
//  Copyright © 2016 RayWenderlich.com. All rights reserved.
//

import Foundation

//MARK: - Equatable Protocol implamentation

func ==(lhs: Chocolate, rhs: Chocolate) -> Bool {
    return (lhs.countryName == rhs.countryName
        && lhs.priceInDollars == rhs.priceInDollars
        && lhs.countryFlagEmoji == rhs.countryFlagEmoji)
}

//MARK: - Mmmm...chocolate...

struct Chocolate: Equatable {
    let priceInDollars: Float
    let countryName: String
    let countryFlagEmoji: String
    
    // An array of chocolate from europe
    static let ofEurope: [Chocolate] = {
        let belgian = Chocolate(priceInDollars: 8,
                                countryName: "Belgium",
                                countryFlagEmoji: "🇧🇪")
        let british = Chocolate(priceInDollars: 7,
                                countryName: "Great Britain",
                                countryFlagEmoji: "🇬🇧")
        let dutch = Chocolate(priceInDollars: 8,
                              countryName: "The Netherlands",
                              countryFlagEmoji: "🇳🇱")
        let german = Chocolate(priceInDollars: 7,
                               countryName: "Germany", countryFlagEmoji: "🇩🇪")
        let swiss = Chocolate(priceInDollars: 10,
                              countryName: "Switzerland",
                              countryFlagEmoji: "🇨🇭")
        
        
        return [
            belgian,
            british,
            dutch,
            german,
            swiss,
        ]
    }()
}

extension Chocolate: Hashable {
    var hashValue: Int {
        return self.countryFlagEmoji.hashValue
    }
}



