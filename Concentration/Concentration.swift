//
//  Concentration.swift
//  Concentration
//
//  Created by Ian Pepin on 2018-10-26.
//  Copyright © 2018 Ian Pepin. All rights reserved.
//

import Foundation

class Concentration {
    
    // The following instance variables are defined.
    var cards = [Card]()
    var indexOfOneAndOnlyFaceUpCard: Int?
    var score = 0
    var flipCount = 0
    var previousCardsFlippedIdentifiers = [Int]()
    
    // The function takes a card and checks to see if it matches a previously flipped.
    // If it matches the card, two points are added to the score. If the card was already
    // flipped and does not match, one point is subtracted from the total score. If there is no
    // match, both cards will be flipped back when the next card is chosen.
    func chooseCard(at index: Int) {
        if !cards[index].isMatched {
            if let matchIndex = indexOfOneAndOnlyFaceUpCard, matchIndex != index {
                previousCardsFlippedIdentifiers.append(matchIndex)
                if cards[matchIndex].identifier == cards[index].identifier {
                    cards[matchIndex].isMatched = true
                    cards[index].isMatched = true
                    score += 2
                } else if previousCardsFlippedIdentifiers.contains(cards[matchIndex].identifier) {
                    score -= 1
                }
                cards[index].isFaceUp = true
                indexOfOneAndOnlyFaceUpCard = nil
            } else {
                for flipDownIndex in cards.indices {
                    cards[flipDownIndex].isFaceUp = false
                }
                cards[index].isFaceUp = true
                indexOfOneAndOnlyFaceUpCard = index
            }
            flipCount += 1
        }
    }
    
    // Initialization of the number of pairs of cards in the game. Creates two identical
    // cards and adds them to the array of cards.
    init(numberOfPairsOfCards: Int) {
        for _ in 1...numberOfPairsOfCards {
            let card = Card()
            cards += [card, card]
        }
        // Shuffles the cards
        cards = cards.shuffled()
    }
}
