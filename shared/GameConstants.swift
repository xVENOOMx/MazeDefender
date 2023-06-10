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
    
    func exploidParticle(position: SCNVector3) {
        if let particalNode = GameProperties().exploidPartical {
            DispatchQueue.main.async {
                var node = particalNode
                node.position = position
                GameProperties().scene.rootNode.addChildNode(node)
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    let exploidNode = GameProperties().scene.rootNode.childNode(withName: node.name ?? "exploidNode", recursively: false)
                    exploidNode?.removeFromParentNode()
                }
                
            }
        } else {
            print("NO PARTICAL")
        }
    }
}
