//
//  ViewController.swift
//  Concentration
//
//  Created by Ian Pepin on 2018-10-25.
//  Copyright © 2018 Ian Pepin. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    // Initializes the game with the number of pairs of cards
    lazy var game = Concentration(numberOfPairsOfCards: (cardButtons.count + 1) / 2)
    
    // Displays the flip count. It updates every time the button is pressed.
    var flipCount = 0 {
        didSet {
            flipCountLabel.text = "Flips: \(flipCount)"
        }
    }
    
    // Displays the score. It updates every time points are made or lost.
    var score = 0 {
        didSet {
            scoreLabel.text = "Score: \(score)"
        }
    }
    
    @IBOutlet weak var flipCountLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet var cardButtons: [UIButton]!
    
    // This method flips a card when the button is pressed. It also executes the chooseCard method
    // to see if the card matches another card.
    @IBAction func touchCard(_ sender: UIButton) {
        if let cardNumber = cardButtons.index(of: sender) {
            game.chooseCard(at: cardNumber)
            updateViewFromModel()
        }
        else {
            print("Chosen card was not in cardButtons")
        }
    }
    
    // This button calls the startNewGame function when pressed
    @IBAction func newGame(_ sender: UIButton) {
        startNewGame()
    }
    
    // This method starts a new game. The number of cards is reset to the original value.
    // A new set is chosen and all the cards are face down.
    func startNewGame() {
        game = Concentration(numberOfPairsOfCards: (cardButtons.count + 1) / 2)
        setTheme()
        updateViewFromModel()
    }
    
    // This method flips a card over. If it is face down, it will flip to show the emoji and a white backgroud.
    // If it is face up, it will flip to either be clear if it was matched or orange if it was not matched.
    func updateViewFromModel() {
        for index in cardButtons.indices {
            let button = cardButtons[index]
            let card = game.cards[index]
            if card.isFaceUp {
                button.setTitle(emoji(for: card), for: UIControl.State.normal)
                button.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            }
            else {
                button.setTitle("", for: UIControl.State.normal)
                button.backgroundColor = card.isMatched ? #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0) : #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1)
            }
        }
        // When a new game starts, the score and the flip count will be 0. Otherwise, it just shows
        // the score and the flip count of the current game.
        score = game.score
        flipCount = game.flipCount
    }
    
    var emojiChoices = ["🦇", "😱", "🙀", "😈", "🎃", "👻", "🍭", "🍬", "🍎"]
    var emoji = [Int:String]()
    let listOfThemes = [
        0: ["🦇", "😱", "🙀", "😈", "🎃", "👻", "🍭", "🍬", "🍎"],
        1: ["⚾️", "⚽️", "🏀", "🏈", "🎾", "🏐", "🏉", "🎱", "🏒"],
        2: ["🥝", "🍓", "🍇", "🍉", "🍌", "🍋", "🍊", "🍐", "🍏"],
        3: ["🐶", "🐱", "🐭", "🦊", "🐻", "🐼", "🦁", "🐸", "🐨"],
        4: ["🚒", "🚎", "🏎", "🚓", "🚑", "🚌", "🚙", "🚕", "🚗"],
        5: ["😀", "😆", "😍", "😎", "😡", "😱", "🤢", "🤑", "😶"]
    ]
    
    // This method set a new random theme every time a new game starts. It choose a theme from
    // the listOfEmojis array. The starting theme is the Halloween theme.
    func setTheme() {
        let theme = Int(arc4random_uniform(UInt32(listOfThemes.keys.count)))
        if let chosenEmojiSet = listOfThemes[theme] {
            emojiChoices = chosenEmojiSet
        }
        else {
            print("Theme #\(theme) is not in the list of themes.")
        }
    }
    
    // This method selects an emoji for each individual card. It then takes the emoji out of the array
    // so that it cannot be selected again.
    func emoji(for card: Card) -> String {
        if emoji[card.identifier] == nil, emojiChoices.count > 0 {
            let randomIndex = Int(arc4random_uniform(UInt32(emojiChoices.count)))
            emoji[card.identifier] = emojiChoices.remove(at: randomIndex)
        }
        return emoji[card.identifier] ?? "?"
    }
}
