//
//  ContentView.swift
//  MazeDefender Watch App
//
//  Created by nick dubov on 30/03/2023.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var gameState: GameState
    @StateObject private var gameProperties = GameProperties()
    
    var body: some View {
        ZStack {
            if gameState.startGame {
                GameView(gameProperties: gameProperties)
                    .ignoresSafeArea()
            } else {
                VStack {
                    Spacer()
                    Image(systemName: "pencil.and.outline")
                    CustomButton(title: "Start") {
                        gameState.restartGameState()
                        gameState.startGame = true
                    }
                    CustomButton(title: "Last Score: \(gameState.score)") {
                        gameState.startGame = true
                    }
                }
            }
        }
    }
}

struct CustomButton: View {
    
    var title: String
    var action: () -> Void
    
    var body: some View {
        ZStack {
                Button(title, action: {
                    action()
                })
                .buttonBorderShape(.roundedRectangle)
                .tint(.green)
            }
    }
}
//
//Button {
//    action()
//} label: {
//    Text(title)
//
//}
//.frame(width: geoProxy.size.width, height: geoProxy.size.height)
//.foregroundColor(.yellow)

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environmentObject(GameState())
    }
}
