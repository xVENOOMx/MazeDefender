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
            sceneRendererDelegate.onEachFrame = { time, renderer in
                // Your code on every frame
                DispatchQueue.main.async {
                    gameProperties.totemNode?.eulerAngles.y = Float(scrollAmount)

                    if time > gameProperties.spawnTime {

                        spawnEnemy()
                        spawnEnemy2()

                        //0.2...1.5
                        gameProperties.spawnTime = time + TimeInterval(Float.random(in: 2...5))
                    }
                }
            }
        }
        .onChange(of: scrollAmount) { newValue in
            //print("newValue", newValue)
        }
        .digitalCrownRotation($scrollAmount, from: 0, through: 999, by: 0.0001, sensitivity: .low, isContinuous: true, isHapticFeedbackEnabled: false)
        }
    
    func spawnEnemy() {
        DispatchQueue.main.async {
            let clone = gameProperties.enemyNode.clone()
            clone.position = gameProperties.spawnNode!.presentation.worldPosition
            gameProperties.scene.rootNode.addChildNode(clone)
            //clone.update(atTime: time, with: renderer)
            clone.runAction(SCNAction.move(to: gameProperties.totemBodyNode!.position, duration: TimeInterval(Int.random(in: 5...7))))
        }
    }
    
    func spawnEnemy2() {
        DispatchQueue.main.async {
            let clone = gameProperties.enemyNode.clone()
            clone.position = gameProperties.spawn2Node!.presentation.worldPosition
            gameProperties.scene.rootNode.addChildNode(clone)
            //clone.update(atTime: time, with: renderer)
            clone.runAction(SCNAction.move(to: gameProperties.totemBodyNode!.position, duration: TimeInterval(Int.random(in: 4...5))))
        }
    }
}


struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView(gameProperties: GameProperties())
    }
}
