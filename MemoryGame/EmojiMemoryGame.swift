//
//  EmojiMemoryGame.swift
//  MemoryGame
//
//  Created by Wojtek Krupowies on 04/05/2021.
//  Copyright © 2021 Wojtek Krupowies. All rights reserved.
//

import SwiftUI

//This is ViewModel in MVVM !
class EmojiMemoryGame {
    
    private var model: Game<String> = EmojiMemoryGame.createMemoryGame()
        
    static func createMemoryGame() -> Game<String> {
        let emojis = ["👻", "🎃", "🦇"]
        return Game<String>(numberOfPairsOfCards: emojis.count) { pairIndex in
            return emojis[pairIndex]
        }
    }
    
    // MARK: - Access to the model
    
    var cards: Array<Game<String>.Card> {
        model.cards //one-liner so we can omit 'return' word 
    }
    
    // MARK: - Intents
    func choose(card: Game<String>.Card){
        model.choose(card: card)
    }
    
}





