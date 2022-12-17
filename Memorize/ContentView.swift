//
//  ContentView.swift
//  Memorize
//
//  Created by tianxingye on 2022/12/1.
//

import SwiftUI


struct ContentView: View {
    
    @ObservedObject var viewModel: EmojiMemoryGame
    
    var body: some View {
        VStack {
            Text("Theme: \(viewModel.chosenTheme.name)")
            ScrollView {
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 65))]) {
                    ForEach(viewModel.cards) { card in
                        CardView(card: card)
                            .aspectRatio(2/3, contentMode: .fit)
                            .onTapGesture {
                                viewModel.choose(card: card)
                            }
                    }
                }
                .foregroundColor(viewModel.chosenColor)
                
                Spacer()
                
                Button {
                    viewModel.startNewGame()
                } label: {
                    Text("New Game").font(.largeTitle)
                }
            }
            .padding()
        }
        .padding(.horizontal)
    }
    
}

struct CardView: View{
    let card: MemoryGame<String>.Card
    
    var body: some View {
        ZStack {
            let shape = RoundedRectangle(cornerRadius: 20)
            if card.isFaceUp {
                shape.fill().foregroundColor(.white)
                shape.strokeBorder(lineWidth: 3)
                Text(card.content).font(.largeTitle)
            } else if card.isMatched {
                shape.opacity(0)
            } else {
                shape.fill()
            }
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(viewModel: EmojiMemoryGame())
    }
}
