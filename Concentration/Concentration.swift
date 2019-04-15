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
    //Метод для выбора карточек
    func choseCard(at index: Int) {
        if  cards[index].isFaceUp {
            cards[index].isFaceUp = false
        } else {
            cards[index].isFaceUp = true
        }
    }
    
    init(numberOfPairsOfCards: Int)  {
        for _ in  1...numberOfPairsOfCards {
            let card = Card()
            cards += [card, card]
        }
    }
}
