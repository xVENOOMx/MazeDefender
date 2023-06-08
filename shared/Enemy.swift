//
//  Enemy.swift
//  MazeDefender Watch App
//
//  Created by nick dubov on 30/03/2023.
//

import Foundation
import SceneKit
import WatchKit

class Enemy: SCNNode {
    
    var previousUpdateTime: TimeInterval = 0
    
    override init() {
        super.init()
        create()
    }
    
    func update(atTime time: TimeInterval, with renderer: SCNSceneRenderer) {
        
    }
    
    func create() {
        
        let box = SCNBox(width: 1, height: 1, length: 1, chamferRadius: 0)
        let matterial = SCNMaterial()
        matterial.diffuse.contents = UIColor.yellow
        matterial.diffuse.intensity = 1
        
        box.materials = [matterial]
        
        self.geometry = box
        self.name = "enemy"
        
        self.physicsBody = .static()
        self.physicsBody?.categoryBitMask = 1
        self.physicsBody?.collisionBitMask = 6
        self.physicsBody?.contactTestBitMask = GameConstants.shared.categoryBody | GameConstants.shared.categoryFront
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
