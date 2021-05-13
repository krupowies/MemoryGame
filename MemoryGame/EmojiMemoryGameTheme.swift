//
//  EmojiMemoryGameTheme.swift
//  MemoryGame
//
//  Created by Wojtek Krupowies on 11/05/2021.
//  Copyright © 2021 Wojtek Krupowies. All rights reserved.
//

import Foundation
import SwiftUI

struct EmojiMemoryGameTheme{
    var name: String
    var emojis: [String]
    var emojisNumber: Int?
    var color: Color
    
    static let animals = EmojiMemoryGameTheme(name: "animals", emojis: ["🐮", "🦦", "🐙", "🦄", "🐬"], emojisNumber: nil, color: .pink)
    static let food = EmojiMemoryGameTheme(name: "food", emojis: ["🥨", "🥕", "🍌", "🍇", "🍉"], emojisNumber: nil, color: .yellow)
    static let sports = EmojiMemoryGameTheme(name: "sports", emojis: ["🏀", "🎾", "🥌", "🚴🏼", "🏊🏼"], emojisNumber: nil, color: .red)
    static let places = EmojiMemoryGameTheme(name: "places", emojis: ["🏕", "🕍", "🏦", "🏡", "🏝"], emojisNumber: nil, color: .green)
    
    static var themes = [animals, food, sports, places]
}
