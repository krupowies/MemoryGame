//
//  Game.swift
//  MemoryGame
//
//  Created by Wojtek Krupowies on 04/05/2021.
//  Copyright © 2021 Wojtek Krupowies. All rights reserved.
//

import Foundation

//This is the Model in MVVM !
struct Game<CardContent> {
    var cards: Array<Card>
    
    func choose(card: Card){
        print("Card chosen: \(card)")
    }
    
    init(numberOfPairsOfCards: Int, cardContentSource: (Int) -> CardContent)  {
        cards = Array<Card>()
        for pairIndex in 0..<numberOfPairsOfCards {
            let content = cardContentSource(pairIndex)
            cards.append(Card(content: content, id: pairIndex*2))
            cards.append(Card(content: content, id: pairIndex*2+1))
        }
        
    }
    
    struct Card: Identifiable{
        var isFaceUp: Bool = true
        var isMatched: Bool = false
        var content: CardContent
        var id: Int
    }
}

