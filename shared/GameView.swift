//
//  GameView.swift
//  MazeDefender Watch App
//
//  Created by nick dubov on 30/03/2023.
//

import SwiftUI
import SceneKit

struct GameView: View {
    
    @ObservedObject var gameProperties: GameProperties
    
    @State private var scrollAmount = 0.0
    
    var sceneRendererDelegate = SceneRendererDelegate()
    
    var body: some View {
        ZStack {
            SceneView(scene: gameProperties.scene, pointOfView: gameProperties.cameraNode, delegate: sceneRendererDelegate)
        }
        .focusable(true)
        .onDisappear {
            // Make sure your code disabled in background
            sceneRendererDelegate.onEachFrame = nil
        }
        .onAppear {
            sceneRendererDelegate.onEachFrame = { time in
                // Your code on every frame
                DispatchQueue.main.async {
                    gameProperties.totemNode?.eulerAngles.y = Float(scrollAmount)

                    if time > gameProperties.spawnTime {

                        spawnEnemy()

                        //0.2...1.5
                        gameProperties.spawnTime = time + TimeInterval(Float.random(in: 3.2...5.5))
                    }
                }
            }
        }
        .onChange(of: scrollAmount) { newValue in
            //print("newValue", newValue)
        }
        .digitalCrownRotation($scrollAmount, from: 0, through: 360, by: 0.1, sensitivity: .low, isContinuous: true, isHapticFeedbackEnabled: false)
        }
    
    func spawnEnemy() {
        DispatchQueue.main.async {
            let clone = gameProperties.enemyNode.clone()
            clone.position = gameProperties.spawnNode!.presentation.worldPosition
            gameProperties.scene.rootNode.addChildNode(clone)
            
            clone.runAction(SCNAction.move(to: gameProperties.totemBodyNode!.position, duration: 10))
        }
    }
}


struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView(gameProperties: GameProperties())
    }
}
