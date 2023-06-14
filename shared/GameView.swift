//
//  GameView.swift
//  MazeDefender Watch App
//
//  Created by nick dubov on 30/03/2023.
//

import SwiftUI
import SceneKit

struct GameView: View {
    
    @EnvironmentObject var gameState: GameState
    @ObservedObject var gameProperties: GameProperties
    
    @State private var scrollAmount = 0.0
    
    var sceneRendererDelegate = SceneRendererDelegate()

    var body: some View {
        ZStack {
            SceneView(scene: gameProperties.scene, pointOfView: gameProperties.cameraNode, delegate: sceneRendererDelegate)
            //ScoreView()
        }
        .ignoresSafeArea()
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
                    
                    if time > gameProperties.commetSpawnTime {
                        
                        spawnCommet()
                        
                        gameProperties.commetSpawnTime = time + TimeInterval(Float.random(in: 15...20))
                    }
                }
            }
        }
        .onChange(of: scrollAmount) { newValue in
            //print("newValue", newValue)
        }
        .digitalCrownRotation($scrollAmount, from: 0, through: 999, by: 0.0001, sensitivity: .low, isContinuous: true, isHapticFeedbackEnabled: false)
    }
    
    func spawnCommet() {
        DispatchQueue.main.async {
            if let clone = gameProperties.commetNode?.clone() {
                if gameProperties.commetFrontSpawn {
                    clone.position = gameProperties.spawnNode!.presentation.worldPosition
                    clone.eulerAngles.y = 90
                } else {
                    clone.position = gameProperties.spawn2Node!.presentation.worldPosition
                    clone.eulerAngles.y = -90
                }
                gameProperties.scene.rootNode.addChildNode(clone)
                clone.runAction(SCNAction.move(to: gameProperties.totemBodyNode!.position, duration: TimeInterval(Int.random(in: 7...10))))
            }
            gameProperties.commetFrontSpawn.toggle()
        }
    }
    
    func spawnEnemy() {
        DispatchQueue.main.async {
            if let clone = gameProperties.asteroidNode?.clone() {
                clone.position = gameProperties.spawnNode!.presentation.worldPosition
                gameProperties.scene.rootNode.addChildNode(clone)
                clone.runAction(SCNAction.move(to: gameProperties.totemBodyNode!.position, duration: TimeInterval(Int.random(in: 5...7))))
            }
        }
    }
    
    func spawnEnemy2() {
        DispatchQueue.main.async {
            if let clone = gameProperties.asteroidNode?.clone() {
                clone.position = gameProperties.spawn2Node!.presentation.worldPosition
                gameProperties.scene.rootNode.addChildNode(clone)
                clone.runAction(SCNAction.move(to: gameProperties.totemBodyNode!.position, duration: TimeInterval(Int.random(in: 4...5))))
            }
        }
    }
}

struct ScoreView: View {
    
    @EnvironmentObject var gameState: GameState
    
    var body: some View {
        ZStack {
            VStack {
                HStack {
                    Text("\(gameState.score)")
                        .padding(.leading, 30)
                        .foregroundColor(.gray)
                    Spacer()
                }
                Spacer()
            }
        }
    }
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView(gameProperties: GameProperties())
            .environmentObject(GameState())
    }
}
