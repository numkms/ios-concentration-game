//
//  ViewController.swift
//  Concentration
//
//  Created by Владимир Курдюков on 13/04/2019.
//  Copyright © 2019 Владимир Курдюков. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    private lazy var game = Concentration(numberOfPairsOfCards: numberOfPairsOfCards)
    @IBOutlet var cardButtons: [UIButton]!
    private(set) var flipCount: Int = 0 {
        didSet{
            updateFlipcount()
        }
    };
    
    @IBAction func startNewGame(_ sender: UIButton) {
        game.start()
        flipCount = 0
        emojiChoices = "👻🤮🤗👀👅🍀"
        updateViewFromModel()
    }
    
    private func updateFlipcount() {
        let attributes : [NSAttributedString.Key : Any] = [
            .strokeWidth: 5.0,
            .strokeColor: #colorLiteral(red: 1, green: 0.6135899425, blue: 0.424477756, alpha: 1)
        ]
        let attributedString = NSAttributedString(string: "Flips: \(flipCount)", attributes: attributes)
        flipCountLabel.attributedText = attributedString
    }
    
    var numberOfPairsOfCards: Int {
        get {
            return cardButtons.count / 2
        }
    }
    
    @IBAction private func touchCard(_ sender: UIButton) {
        if let cardNumber = cardButtons.firstIndex(of: sender) {
            flipCount += 1
            game.choseCard(at: cardNumber)
            updateViewFromModel();
        } else {
            print("this button doesnt exist in cardButtons array")
        }
    }
    
    private func updateViewFromModel() {
        for index in cardButtons.indices {
            let button =  cardButtons[index]
            let card = game.cards[index]
            if  card.isFaceUp {
                button.setTitle(emoji(for: card), for: UIButton.State.normal)
                button.backgroundColor = #colorLiteral(red: 1, green: 0.6135899425, blue: 0.424477756, alpha: 1)
            } else {
                button.setTitle("",  for: UIButton.State.normal)
                button.backgroundColor = card.isMatched ? #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0) : #colorLiteral(red: 0, green: 0.9810667634, blue: 0.5736914277, alpha: 1)
            }
        }
    }
    
    @IBOutlet private weak var flipCountLabel: UILabel! {
        didSet {
            updateFlipcount()
        }
    }
    
    private var emojiChoices = "👻🤮🤗👀👅🍀"
    private var emoji =  [Card:String]();
    
    private func emoji(for card: Card) -> String {
        let randomStringIndex = emojiChoices.index(emojiChoices.startIndex, offsetBy: emojiChoices.count.arc4random)
        if emojiChoices.count > 0, emoji[card] == nil {
            emoji[card] = String(emojiChoices.remove(at: randomStringIndex))
        }
        return emoji[card] ?? "?"
    }
}

extension Int {
    var arc4random: Int {
        if self > 0 {
            return Int(arc4random_uniform(UInt32(self)))
        }  else if self < 0 {
            return -Int(arc4random_uniform(UInt32(abs(self))))
        } else {
            return 0;
        }
        
    }
}
