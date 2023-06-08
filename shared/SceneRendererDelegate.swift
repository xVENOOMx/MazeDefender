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
    var onEachFrame: ((_ time: TimeInterval) -> ())? = nil
    
    func renderer(_ renderer: SCNSceneRenderer, updateAtTime time: TimeInterval) {
        if self.renderer == nil {
            self.renderer = renderer
            let type = type(of: renderer)
            renderer.scene?.physicsWorld.contactDelegate = self
            renderer.isPlaying = true
            print("We got SceneRenderer: \(type)")
        }
        
        onEachFrame?(time)
    }
    
    var enemyCound = 0
    var bodyCound = 0
    var frontCount = 0
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
            
            print(contactNode.name as Any)
            
            if contactNode.physicsBody?.categoryBitMask == GameConstants.shared.categoryEnemy {

            }

            if contactNode.physicsBody?.categoryBitMask == GameConstants.shared.categoryBody {

            }

            if contactNode.physicsBody?.categoryBitMask == GameConstants.shared.categoryFront {
                self.frontCount += 1
                print("front", self.frontCount)
            }
        }
    }
    
    func hideNode(node: SCNNode) {
        DispatchQueue.main.async {
            node.isHidden = true
        }
    }
}
