//
//  GameProperties.swift
//  MazeDefender Watch App
//
//  Created by nick dubov on 30/03/2023.
//

import Foundation
import SceneKit

class GameProperties: ObservableObject {
    
    @Published var scene = SCNScene(named: "Assets.scnassets/Level.scn")!
    
    var spawnTime: TimeInterval = 0
    
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
    
    var spawnNode: SCNNode? {
        scene.rootNode.childNode(withName: "spawn", recursively: false)
    }
    
    let enemyNode = Enemy()
}
