//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by tianxingye on 2022/12/14.
//

import SwiftUI


class EmojiMemoryGame: ObservableObject {
    
    static private var vehicleEmojis = ["🚗", "🛴", "✈️", "🛵", "⛵️", "🚎", "🚐", "🚛", "🛻", "🏎", "🚂", "🚊", "🚀", "🚁", "🚢", "🛶", "🛥", "🚞", "🚟", "🚃"]
    static private var animalEmojis = ["🐶", "🐱", "🐭", "🐹", "🐰", "🦊", "🐻", "🐼", "🐻‍❄️", "🐨", "🐯", "🦁", "🐮", "🐷", "🐵"]
    static private var foodEmojis = ["🍔", "🥐", "🍕", "🥗", "🥟", "🍣", "🍪", "🍚", "🍝", "🥙", "🍭", "🍤", "🥞", "🍦", "🍛", "🍗"]
    static private var heartEmojis = ["❤️", "🧡", "💛", "💚", "💙", "💜"]
    static private var sportsEmojis = ["⚽️", "🏀", "🏈", "⚾️", "🎾", "🏉", "🥏", "🏐", "🎱", "🏓", "🏸", "🏒", "🥊", "🚴‍♂️", "🏊", "🧗‍♀️", "🤺", "🏇", "🏋️‍♀️", "⛸", "⛷", "🏄", "🤼"]
    static private var weatherEmojis = ["☀️", "🌪", "☁️", "☔️", "❄️"]
    
    static private let colors = [
        "black", "gray", "red", "green", "blue", "orange",
        "yellow", "pink", "purple", "fushia", "beige", "gold"
    ]
    
    static func getColor(_ chosenColor: String) -> Color {
        switch chosenColor {
        case "black":
            return .black
        case "gray":
            return .gray
        case "red":
            return .red
        case "green":
            return .green
        case "blue":
            return .blue
        case "orange":
            return .orange
        case "yellow":
            return .yellow
        case "pink":
            return .pink
        case "purple":
            return .purple
        default:
            return .red
        }
    }
    
    static func createTheme(_ name: String, _ emojis: [String], _ defaultPairsOfCards: Int) -> Theme {
        
        let color = colors.randomElement()!
        
        // defaultPairsOfCards这个值不能改，需要定义一个变量numberOfParisOfCards
        var numberOfParisOfCards = defaultPairsOfCards
        if emojis.count < defaultPairsOfCards {
            numberOfParisOfCards = emojis.count
        }
        
        return Theme(
            name: name,
            color: color,
            emojis: emojis,
            numberOfPairsOfCards: numberOfParisOfCards)
    }
    
    static var themes: [Theme] {
        var themes = [Theme]()
        let defaultPairsOfCards = 8
        themes.append(createTheme("Vehicles", vehicleEmojis, defaultPairsOfCards))
        themes.append(createTheme("Animals", animalEmojis, defaultPairsOfCards))
        themes.append(createTheme("Food", foodEmojis, defaultPairsOfCards))
        themes.append(createTheme("Hearts", heartEmojis, defaultPairsOfCards))
        themes.append(createTheme("Sports", sportsEmojis, defaultPairsOfCards))
        themes.append(createTheme("Weather", weatherEmojis, defaultPairsOfCards))
        return themes
    }
    
    static func createMemoryGame(of chosenTheme: Theme) -> MemoryGame<String> {
        var numberOfPairsOfCards = chosenTheme.numberOfPairsOfCards
        return MemoryGame<String>(numOfPairsOfCards: numberOfPairsOfCards){ chosenTheme.emojis[$0] }
    }
    
    private(set) var chosenTheme: Theme
    private(set) var chosenColor: Color?
    @Published private var model: MemoryGame<String>
    
    static func choseTheme() -> Theme {
        EmojiMemoryGame.themes.randomElement()!
    }
    
    init() {
        // 先选主题
        chosenTheme = EmojiMemoryGame.choseTheme()
        // 选择颜色
        chosenColor = EmojiMemoryGame.getColor(chosenTheme.color)
        // 创建model
        model = EmojiMemoryGame.createMemoryGame(of: chosenTheme)
    }
    
    var cards: [MemoryGame<String>.Card] {
        model.cards
    }
    
    // MARK: - Intent(s)
    
    func choose(card: MemoryGame<String>.Card) {
        model.choose(card: card)
    }
    
    func startNewGame() {
        // 和init函数一样
        chosenTheme = EmojiMemoryGame.choseTheme()
        chosenColor = EmojiMemoryGame.getColor(chosenTheme.color)
        model = EmojiMemoryGame.createMemoryGame(of: chosenTheme)
    }
}
