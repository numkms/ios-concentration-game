//
//  ViewController.swift
//  Concentration
//
//  Created by Владимир Курдюков on 13/04/2019.
//  Copyright © 2019 Владимир Курдюков. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    lazy var game = Concentration(numberOfPairsOfCards: cardButtons.count / 2)
    
    @IBOutlet var cardButtons: [UIButton]!
    var emojiChoices = ["👻", "🤮", "🤗", "👻", "👀", "👅", "🍀", "🍀", "🤮", "🤗", "👀", "👅"]
    var flipCount: Int = 0 {
        didSet{
            flipCountLabel.text = "Flips: \(flipCount)"
        }
    };
    //@IBAction - говорит икскоду что это экшен
    //func - говорит о том что это функция (в данном случае метод)
    //touchCard - название метода
    //
    @IBAction func touchCard(_ sender: UIButton) {
        if let cardNumber = cardButtons.firstIndex(of: sender) {
            game.choseCard(at: cardNumber)
            updateViewFromModel();
        } else {
            print("this button doesnt exist in cardButtons array")
        }
    }
    
    func updateViewFromModel() {
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
    
    @IBOutlet weak var flipCountLabel: UILabel!
    func flipCard(withEmoji emoji: String, on button: UIButton) {
        if button.currentTitle == emoji {
            button.setTitle("", for: UIControl.State.normal)
            button.backgroundColor = #colorLiteral(red: 0, green: 0.9810667634, blue: 0.5736914277, alpha: 1)
        
        } else {
            button.setTitle(emoji, for: UIControl.State.normal)
            button.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        }
        flipCount += 1
    }
    
    func emoji(for card: Card) -> String {
        return "?"
    }
}
