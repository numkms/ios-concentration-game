//
//  Concentration.swift
//  Concentration
//
//  Created by Владимир Курдюков on 15/04/2019.
//  Copyright © 2019 Владимир Курдюков. All rights reserved.
//

import Foundation

struct Concentration
{
    private (set) var cards = [Card]()
    var score = 0
    var flipCount = 0
    var sawedEmojis: [Int] = []
    var emojiChoices = "???????"
    
    private (set) var themes : [String:String] = [
        "animals":"🐝🐒🐷🐔🐧🐤🦄",
        "activity":"🏀🥎🥊🏓🥏🏹🥎",
        "faces":"🥰🤪😇😎😛🥶",
        "hands":"✌🏻☝🏻💪👎🏽👈🤙🏻",
        "family":"👨‍👩‍👧‍👧💏👩‍👩‍👧👨‍👨‍👧‍👧👨‍👨‍👦👩‍👦",
        "flags":"🇲🇬🇲🇸🏳️‍🌈🇺🇸🇯🇵🇵🇭"
    ]
    private var numberOfPairsOfCards: Int = 0
    
    func randomTheme() -> String {
        return themes.randomElement()?.value ?? "??????";
    }
    
    private var indexOfOneAndOnlyFaceUpCard: Int? {
        get {
            return cards.indices.filter({ cards[$0].isFaceUp }).oneAndOnly
        }
        set(newValue)  {
            for index in cards.indices {
                cards[index].isFaceUp  = (index == newValue)
            }
        }
    }
    //Метод для выбора карточек
    mutating func choseCard(at index: Int) {
        assert(cards.indices.contains(index), "Concentration.choseCard(at: \(index) chosen index not in these cards")
        if !cards[index].isMatched {
            if let matchIndex = indexOfOneAndOnlyFaceUpCard, matchIndex != index {
                if cards[matchIndex] == cards[index] {
                    cards[matchIndex].isMatched =  true
                    cards[index].isMatched = true
                    score += 2
                } else {
                    if sawedEmojis.contains(index) {
                        score -= 1
                    }
                }
                cards[index].isFaceUp = true
                indexOfOneAndOnlyFaceUpCard = nil
                sawedEmojis.append(index)
            } else {
                indexOfOneAndOnlyFaceUpCard = index
            }
        }
        flipCount += 1
    }
    
    init(numberOfPairsOfCards: Int)  {
        self.numberOfPairsOfCards = numberOfPairsOfCards
        start()
    }
    
     mutating func start() {
        cards = []
        emojiChoices = randomTheme()
        flipCount = 0
        assert(numberOfPairsOfCards > 0, "Concentration.init(numberOfPairOfCards: \(numberOfPairsOfCards) you must have at least in pair of cards")
        for _ in  1...numberOfPairsOfCards {
            let card = Card()
            cards += [card, card]
        }
        cards = cards.shuffled();
    }
}

extension Collection {
    var oneAndOnly: Element? {
        return count == 1 ? first : nil
    }
}
