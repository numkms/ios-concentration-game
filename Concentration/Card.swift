//
//  Card.swift
//  Concentration
//
//  Created by Владимир Курдюков on 15/04/2019.
//  Copyright © 2019 Владимир Курдюков. All rights reserved.
//

import Foundation

struct Card: Hashable
{
    static func == (lhs: Card, rhs: Card) -> Bool {
        return lhs.identifier == rhs.identifier
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(identifier)
    }
    
    var isFaceUp = false
    var isMatched = false
    var identifier: Int
    private static var identifierFactory = 0;
    private static func getUniqueIdentifier() -> Int {
        identifierFactory += 1
        return identifierFactory;
    }
    
    init() {
        self.identifier = Card.getUniqueIdentifier()
    }
}
