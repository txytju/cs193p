//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by tianxingye on 2022/12/14.
//

import Foundation


class EmojiMemoryGame: ObservableObject {
    
    static var emojis_vehicles = ["🚲", "🚂", "🚁", "🚜", "🚕", "🏎️", "🚐", "🚓", "🚒", "✈️", "🚀", "🚨", "🛸", "🛶", "🚌", "🛵", "🏍️", "🚇", "🛞", "🚆", "🚊", "🛥️", "🛳️", "🚢"]
    
    static func createMemoryGame() -> MemoryGame<String> {
        return MemoryGame<String>(numOfPairsOfCards: 4, createContent: createEmojiString)
    }
    
    static func createEmojiString(index: Int) -> String {
        return emojis_vehicles[index]
    }
    
    @Published private var model: MemoryGame<String> = createMemoryGame()
    
    
    var cards: [MemoryGame<String>.Card] {
        model.cards
    }
    
    // MARK: - Intent(s)
    
    func choose(card: MemoryGame<String>.Card) {
        model.choose(card: card)
    }
}
