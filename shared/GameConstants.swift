//
//  GameConstants.swift
//  MazeDefender Watch App
//
//  Created by Nick Dubov on 08/06/2023.
//

import Foundation
import SceneKit

class GameConstants {
    
    static let shared = GameConstants()
    
    let categoryEnemy = 1
    let categoryBody = 2
    let categoryFront = 4
    
    //start game
    let asteroidSpawnTimePeriod = 2...5
    let commetSpawnTimePerid = 20...30
    
    let spawnActionSpeed = 5...7
    let spawn2ActionSpeed = 4...5
    
    //harder
    let asteroidSpawnTimePeriodHard = 2...3.5
    let commetSpawnTimePeridHard = 10...15
    
    let spawnActionSpeedHard = 4...6
    let spawn2ActionSpeedHard = 3.5...4
}
