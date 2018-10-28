//
//  Card.swift
//  Concentration
//
//  Created by Ian Pepin on 2018-10-26.
//  Copyright © 2018 Ian Pepin. All rights reserved.
//

import Foundation

// Sets the default value for a card. Each card starts face down,
// not matched and with a certain identifier.
struct Card {
    var isFaceUp = false
    var isMatched = false
    var identifier: Int
    
    static var identifierFactory = 0
    
    static func getUniqueIdentifier() -> Int{
        identifierFactory += 1
        return identifierFactory
    }
    
    // Initializes the identifier of a card to an integer.
    init() {
        self.identifier = Card.getUniqueIdentifier()
    }
}
