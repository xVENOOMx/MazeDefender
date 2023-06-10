//
//  SceneRendererDelegate.swift
//  MazeDefender Watch App
//
//  Created by nick dubov on 30/03/2023.
//

import Foundation
import SceneKit
import SwiftUI

// the hackiest hack ever. And the stupidest one!
// For handling touches in SceneView we need SCNSceneRenderer,
// but SwiftUI's SceneView does not provide it.
class SceneRendererDelegate: NSObject, SCNSceneRendererDelegate {
    
    var renderer: SCNSceneRenderer?
    var onEachFrame: ((_ time: TimeInterval, _ render: SCNSceneRenderer) -> ())? = nil
    
    func renderer(_ renderer: SCNSceneRenderer, updateAtTime time: TimeInterval) {
        if self.renderer == nil {
            self.renderer = renderer
            let type = type(of: renderer)
            renderer.scene?.physicsWorld.contactDelegate = self
            renderer.isPlaying = true
            print("We got SceneRenderer: \(type)")
        }
        
        onEachFrame?(time, renderer)
    }
    
    var enemyCound = 0
    var HP = 3
    var asteroidDestroied = 0
}

extension SceneRendererDelegate: SCNPhysicsContactDelegate {
    
    func physicsWorld(_ world: SCNPhysicsWorld, didBegin contact: SCNPhysicsContact) {

        DispatchQueue.main.async {
            var contactNode: SCNNode!
            var enemyContactNode: SCNNode!
        
            if contact.nodeA.name == "enemy" {
                contactNode = contact.nodeB
                enemyContactNode = contact.nodeA
            } else {
                contactNode = contact.nodeA
                enemyContactNode = contact.nodeB
            }
            
            //print(contactNode.name as Any)
            
//            if contactNode.physicsBody?.categoryBitMask == GameConstants.shared.categoryEnemy {
//
//            }

            if contactNode.physicsBody?.categoryBitMask == GameConstants.shared.categoryBody {
                self.hideNode(node: enemyContactNode)
                self.HP -= 1
                print("HP, \(self.HP)")
            }
            
            if contact.nodeA.physicsBody?.categoryBitMask == GameConstants.shared.categoryFront || contact.nodeB.physicsBody?.categoryBitMask == GameConstants.shared.categoryEnemy {
                self.hideNode(node: enemyContactNode)
                self.asteroidDestroied += 1
                print("destroied: \(self.asteroidDestroied)")
            }
//            if contactNode.physicsBody?.categoryBitMask == GameConstants.shared.categoryFront {
//                self.hideNode(node: enemyContactNode)
//                self.asteroidDestroied += 1
//                print("destroied: \(self.asteroidDestroied)")
//            }
            
            
        }
    }
    
    func hideNode(node: SCNNode) {
        DispatchQueue.main.async {
            node.isHidden = true
            node.removeFromParentNode()
        }
    }
}
