//
//  MazeDefenderApp.swift
//  MazeDefender Watch App
//
//  Created by nick dubov on 30/03/2023.
//

import SwiftUI

@main
struct MazeDefender_Watch_AppApp: App {
    
    @StateObject var gameState: GameState = GameState()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(gameState)
        }
    }
}
