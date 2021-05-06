//
//  ContentView.swift
//  MemoryGame
//
//  Created by Wojtek Krupowies on 03/05/2021.
//  Copyright © 2021 Wojtek Krupowies. All rights reserved.
//

import SwiftUI

struct EmojiMemoryGameView: View {
    @ObservedObject var viewModel: EmojiMemoryGame
    
    var body: some View {
        HStack{
            ForEach(viewModel.cards.shuffled()){ card in
                CardView(card: card).onTapGesture {
                    self.viewModel.choose(card: card)
                }
            }
        }
        .padding()
        .foregroundColor(Color.orange)
        .font(viewModel.cards.count == 10 ? Font.caption : Font.largeTitle)
    }
}

struct CardView: View{
    var card: Game<String>.Card
    
    var body: some View{
        
        ZStack{
            if card.isFaceUp {
                RoundedRectangle(cornerRadius: 10.0).fill(Color.white)
                RoundedRectangle(cornerRadius: 10.0).stroke(lineWidth: 3)
                Text(card.content)
            } else {
                RoundedRectangle(cornerRadius: 10.0).fill()
            }
        }
        .aspectRatio(0.66, contentMode: .fit)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        EmojiMemoryGameView(viewModel: EmojiMemoryGame()).previewDevice(PreviewDevice(rawValue: "iPhone XR"))
    }
}
