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
    
    override init() {
        super.init()
        create()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func create() {
        
        let box = SCNSphere(radius: 1)
        let matterial = SCNMaterial()
        matterial.diffuse.contents = UIColor.red
        matterial.diffuse.intensity = 1
       // print(" box.materials.isEmpty",  box.materials.isEmpty)
        
        box.materials = [matterial]
        
        self.geometry = box
        self.name = "enemy"
        
        self.physicsBody = .dynamic()
        self.physicsBody?.categoryBitMask = 1
        self.physicsBody?.collisionBitMask = 6
        self.physicsBody?.contactTestBitMask = GameConstants.shared.categoryBody | GameConstants.shared.categoryFront
    }
}
