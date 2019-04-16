//
//  Concentration.swift
//  Concentration
//
//  Created by Владимир Курдюков on 15/04/2019.
//  Copyright © 2019 Владимир Курдюков. All rights reserved.
//

import Foundation

class Concentration
{
    //Тут мы говорим о том, что в этом свойстве будет массив структур карточек
    var cards = [Card]()
    
    var indexOfOneAndOnlyFaceUpCard: Int? {
        get {
            var foundIndex: Int?
            for index in cards.indices {
                if cards[index].isFaceUp {
                    if foundIndex == nil {
                        foundIndex = index
                    } else  {
                        return nil
                    }
                }
            }
            return foundIndex
        }
        set(newValue)  {
            for index in cards.indices {
                cards[index].isFaceUp  = (index == newValue)
            }
        }
    }
    //Метод для выбора карточек
    func choseCard(at index: Int) {
        if !cards[index].isMatched {
            if let matchIndex = indexOfOneAndOnlyFaceUpCard, matchIndex != index {
                if cards[matchIndex].identifier == cards[index].identifier  {
                    cards[matchIndex].isMatched =  true
                    cards[index].isMatched = true
                }
                cards[index].isFaceUp = true
                indexOfOneAndOnlyFaceUpCard = nil
            } else {    
                indexOfOneAndOnlyFaceUpCard = index
            }
        }
    }
    
    init(numberOfPairsOfCards: Int)  {
        for _ in  1...numberOfPairsOfCards {
            let card = Card()
            cards += [card, card]
        }
        cards = cards.shuffled();
    }
}
