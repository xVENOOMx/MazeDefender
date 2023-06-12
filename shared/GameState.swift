//
//  GameState.swift
//  MazeDefender Watch App
//
//  Created by Nick Dubov on 11/06/2023.
//

import Foundation

class GameState: ObservableObject {
    
    static let shared = GameState()
    
    @Published var startGame = false
    @Published var score = 0
    @Published var health = 3
    
    func addScore() {
        score += 1
    }
    
    func getDemage() {
        health -= 1
    }
    
    func restartGameState() {
        health = 3
        score = 0
    }
}
