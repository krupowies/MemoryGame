//
//  Game.swift
//  MemoryGame
//
//  Created by Wojtek Krupowies on 04/05/2021.
//  Copyright © 2021 Wojtek Krupowies. All rights reserved.
//

import Foundation

//This is the Model in MVVM !
struct Game<CardContent> where CardContent : Equatable {
    private(set) var cards: Array<Card>
    var score: Int
    
    private var indexOfTheOneFaceUpCard: Int? {
        get { cards.indices.filter { cards[$0].isFaceUp}.only }
        
        set {
            for index in cards.indices {
                if index == newValue {
                    cards[index].isFaceUp = true
                } else {
                    cards[index].isFaceUp = false
                }
            }
        }
    }
    
    mutating func choose(card: Card) {
        print("Card chosen: \(card)")
        if let chosenIndex: Int = cards.firstIndex(matching: card), !cards[chosenIndex].isFaceUp, !cards[chosenIndex].isMatched {
            if let potencialMatchedCard = indexOfTheOneFaceUpCard {
                if cards[chosenIndex].content == cards[potencialMatchedCard].content {
                    cards[chosenIndex].isMatched = true
                    cards[potencialMatchedCard].isMatched = true
                    score = score + 1
                }
                self.cards[chosenIndex].isFaceUp = true
            } else {
                indexOfTheOneFaceUpCard = chosenIndex                
            }
        }
    }
    
    init(numberOfPairsOfCards: Int, cardContentSource: (Int) -> CardContent)  {
        score = 0
        cards = Array<Card>()
        for pairIndex in 0..<numberOfPairsOfCards {
            let content = cardContentSource(pairIndex)
            cards.append(Card(content: content, id: pairIndex*2))
            cards.append(Card(content: content, id: pairIndex*2+1))
        }
        cards.shuffle()
    }
    
    struct Card: Identifiable {
        var isFaceUp: Bool = false {
            didSet {
                if isFaceUp {
                    startUsingBonusTime()
                } else {
                    stopUsingBonusTime()
                }
            }
        }
        var isMatched: Bool = false {
            didSet {
                stopUsingBonusTime()
            }
        }
        var content: CardContent
        var id: Int
        
        // MARK: - Bonus Time
        /// It gives bonus points if user matches the card before a certain amount of time during which the card is face up
        
        // can be zero which means "no bonus available" for this card
        var bonusTimeLimit: TimeInterval = 6
        
        // how long this card has even been face up
        private var faceUpTime: TimeInterval {
            if let lastFaceUpDate = self.lastFaceUpDate {
                return pastFaceUpTime + Date().timeIntervalSince(lastFaceUpDate)
            } else {
                return pastFaceUpTime
            }
        }
        
        // the last time this card was turned up (and is still face up)
        var lastFaceUpDate: Date?
        
        // the accumulated time this card has been face up in the past
        /// not incuding the current time it's been face up if it is currently so
        var pastFaceUpTime: TimeInterval = 0
        
        // how much time left before the bonus opportunity runs out
        var bonusTimeRemaining: TimeInterval {
            max(0, bonusTimeLimit - faceUpTime)
        }
        
        // % of the bonus time remaining
        var bonusRemaining: Double {
            (bonusTimeLimit > 0 && bonusTimeRemaining > 0) ? bonusTimeRemaining / bonusTimeLimit : 0
        }
        
        // whether the card was matched during the bonus time period
        var hasEarnedBonus: Bool {
            isMatched && bonusTimeRemaining > 0
        }
        
        // whether we are currently face up, unmatched and have not yet used up the bonus window
        var isConsumingBonusTime: Bool {
            isFaceUp && !isMatched && bonusTimeRemaining > 0
        }
        
        // called when the card transitions to face up state
        private mutating func startUsingBonusTime() {
            if isConsumingBonusTime, lastFaceUpDate == nil {
                lastFaceUpDate = Date()
            }
        }
        
        // called when the card goes back face down (or gets matched)
        private mutating func stopUsingBonusTime() {
            pastFaceUpTime = faceUpTime
            lastFaceUpDate = nil
        }
        
    }
}
