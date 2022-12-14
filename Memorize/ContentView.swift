//
//  ContentView.swift
//  Memorize
//
//  Created by tianxingye on 2022/12/1.
//

import SwiftUI


struct ContentView: View {
    
    @State var emojis_vehicles = ["🚲", "🚂", "🚁", "🚜", "🚕", "🏎️", "🚐", "🚓", "🚒", "✈️", "🚀", "🚨", "🛸", "🛶", "🚌", "🛵", "🏍️", "🚇", "🛞", "🚆", "🚊", "🛥️", "🛳️", "🚢"]
    @State var emojiCount_vechiles = 10
    @State var emoji_on_vechiles = false
    
    @State var emojis_animals = ["🐶", "🐱", "🐹", "🐭", "🐰", "🦊", "🐻", "🐼", "🐻‍❄️", "🐨", "🐯", "🦁", "🐮", "🐷", "🐽", "🐸", "🐵", "🙈", "🙉", "🙊", "🐒", "🐔", "🐧", "🐦", "🐤"]
    @State var emojiCount_animals = 12
    @State var emoji_on_animals = false
    
    @State var emojis_emojis = ["😀", "😃", "😄", "😁", "😆", "🥹", "😅", "😂", "🤣", "🥲", "☺️", "😊", "😇", "🙂", "🙃", "😉", "😌", "😍", "🥰", "😘", "😗", "😋", "😛", "😝"]
    @State var emojiCount_emojis = 14
    @State var emoji_on_emojis = false
    
    @State var emojis: [String] = []
    
    @State var emojiCount = 0
    
    var body: some View {
        VStack {
            Text("Memorize!")
                .font(.largeTitle)
            ScrollView {
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 65))]) {
                    ForEach(emojis[0..<min(emojiCount, emojis.count)], id: \.self) { emoji in
                        CardView(content: emoji)
                            .aspectRatio(2/3, contentMode: .fit)
                    }
                }
                .foregroundColor(.red)
            }
            Spacer()
            HStack {
                remove
                Spacer()
                add
            }
            .font(.largeTitle)
            .padding(.horizontal)
            Spacer()
            HStack {
                select_emoji_emojis
                Spacer()
                select_emoji_animals
                Spacer()
                select_emoji_vichile
            }
            .padding(.horizontal)
        }
        .padding(.horizontal)
    }
    
    var remove: some View {
        Button {
            if emojiCount > 1 {
                emojiCount -= 1
            }
        } label : {
            Image(systemName: "minus.circle")
        }
    }
    
    var add: some View {
        Button {
            if emojiCount < emojis.count {
                emojiCount += 1
            }
        } label: {
            Image(systemName: "plus.circle")
        }
    }
    
    var select_emoji_vichile: some View {
        Button {
            // 这样的话多一个类型就要多一些代码，扩展性差
            // 如何将这些重复的代码去掉？
            if emoji_on_vechiles {
                emojiCount_vechiles = emojiCount
            }
            if emoji_on_emojis {
                emojiCount_emojis = emojiCount
            }
            if emoji_on_animals {
                emojiCount_animals = emojiCount
            }
            // 调整激活的状态
            emoji_on_vechiles = true
            emoji_on_emojis = false
            emoji_on_animals = false
            
            emojis_vehicles.shuffle()
            emojis = emojis_vehicles
            emojiCount = emojiCount_vechiles
        } label: {
            VStack {
                Image(systemName: "car.fill")
                    .font(.largeTitle)
                Text("vichile")
            }
        }
    }
    
    var select_emoji_emojis: some View {
        Button {
            if emoji_on_vechiles {
                emojiCount_vechiles = emojiCount
            }
            if emoji_on_emojis {
                emojiCount_emojis = emojiCount
            }
            if emoji_on_animals {
                emojiCount_animals = emojiCount
            }
            // 调整激活的状态
            emoji_on_vechiles = false
            emoji_on_emojis = true
            emoji_on_animals = false
            
            emojis_emojis.shuffle()
            emojis = emojis_emojis
            emojiCount = emojiCount_emojis
        } label: {
            VStack {
                Image(systemName: "face.smiling.inverse")
                    .font(.largeTitle)
                Text("emoji")
            }
        }
    }
    
    var select_emoji_animals: some View {
        Button {
            if emoji_on_vechiles {
                emojiCount_vechiles = emojiCount
            }
            if emoji_on_emojis {
                emojiCount_emojis = emojiCount
            }
            if emoji_on_animals {
                emojiCount_animals = emojiCount
            }
            // 调整激活的状态
            emoji_on_vechiles = false
            emoji_on_emojis = false
            emoji_on_animals = true
            
            emojis_animals.shuffle()
            emojis = emojis_animals
            emojiCount = emojiCount_animals
        } label: {
            VStack {
                Image(systemName: "questionmark.square.fill")
                    .font(.largeTitle)
                Text("emoji")
            }
        }
    }
    
}


struct CardView: View{
    var content: String
    @State var isFaceUp: Bool = true
    
    var body: some View {
        ZStack {
            let shape = RoundedRectangle(cornerRadius: 20)
            if isFaceUp {
                shape.fill().foregroundColor(.white)
                shape.strokeBorder(lineWidth: 3)
                Text(content).font(.largeTitle)
            } else {
                shape.fill()
            }
        }
        .onTapGesture {
            isFaceUp = !isFaceUp
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
