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
    
    mutating func choose(card: Card) {
        print("Card chosen: \(card)")
        let chosenIndex: Int = self.index(of: card) ?? 0
        self.cards[chosenIndex].isFaceUp = !self.cards[chosenIndex].isFaceUp
    }
    
    func index(of card: Card) -> Int? { //external&internal name here !
        for index in 0...self.cards.count{
            if self.cards[index].id == card.id{
                return index
            }
        }
        return nil
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

