//
//  GameProperties.swift
//  MazeDefender Watch App
//
//  Created by nick dubov on 30/03/2023.
//

import Foundation
import SceneKit
import SpriteKit

class GameProperties: ObservableObject {
    
    static let shared = GameProperties()
    
    @Published var scene = SCNScene(named: "Assets.scnassets/Level.scn")!
    @Published var commetScene = SCNScene(named: "Assets.scnassets/Commet.scn")!
    @Published var asteroidScene = SCNScene(named: "Assets.scnassets/Asteroid.scn")!
    
    //let enemyNode = Enemy()
    
    var spawnTime: TimeInterval = 0
    var commetSpawnTime: TimeInterval = 0
    
    var commetFrontSpawn = false
    
    var asteroidNode: SCNNode? {
        let asteroid = asteroidScene.rootNode.childNode(withName: "asteroid", recursively: false)
        asteroid?.physicsBody?.contactTestBitMask = GameConstants.shared.categoryBody | GameConstants.shared.categoryFront
        return asteroid
    }
    
    var commetNode: SCNNode? {
        let commet = commetScene.rootNode.childNode(withName: "commet", recursively: false)
        commet?.physicsBody?.contactTestBitMask = GameConstants.shared.categoryBody | GameConstants.shared.categoryFront
        return commet
    }
    
    var cameraNode: SCNNode? {
        scene.rootNode.childNode(withName: "camera", recursively: false)
    }
    
    var totemNode: SCNNode? {
        scene.rootNode.childNode(withName: "totem", recursively: false)
    }
    
    var totemBodyNode: SCNNode? {
        scene.rootNode.childNode(withName: "body", recursively: true)
    }
    
    var totemFrontNode: SCNNode? {
        scene.rootNode.childNode(withName: "front", recursively: true)
    }
    
    var particalFrontNode: SCNNode? {
        scene.rootNode.childNode(withName: "frontPartical", recursively: true)
    }
    
    var spawnNode: SCNNode? {
        scene.rootNode.childNode(withName: "spawn", recursively: false)
    }
    
    var spawn2Node: SCNNode? {
        scene.rootNode.childNode(withName: "spawn2", recursively: false)
    }
}
