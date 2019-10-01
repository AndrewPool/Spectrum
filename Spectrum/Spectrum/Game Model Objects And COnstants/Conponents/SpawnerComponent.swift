//
//  VisualComponent.swift
//  Spectrum
//
//  Created by Andrew Pool on 9/28/19.
//  Copyright © 2019 TokenResearch. All rights reserved.
//

import GameKit

class SpawnerComponent: GKComponent{
    
    let shapeNode : SpectrumShape
    weak var spawnerEntity : SpawnerEntity?
    
    private var spawnCountdown = 0.0
      
    
    convenience init(shape: Shape, player:Player, size:Int, scene:SpectrumScene){
        
        let shape = SpectrumShape(shape: shape, player: player, size: size)
        
        self.init(shape, scene)
    }
    
    init(_ spectrumShape:SpectrumShape,_ scene:SpectrumScene){
        
        shapeNode = spectrumShape
        
        super.init()
        //this is gross but i mean what can you do
        
        shapeNode.setUpCollisionAsSpawner()
        
    }
    func setEntity(){
        let parent = entity as! SpawnerEntity
        spawnerEntity = parent
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //-------------update and helpers----------------------
    override func update(deltaTime seconds: TimeInterval) {
        print("truing")
        tryToSpawn(deltaTime:seconds)
    }
    
    private func tryToSpawn(deltaTime: TimeInterval){
        if (spawnCountdown <= 0){
            spawnBuddy()
             spawnCountdown += Constants.Spawner.spawnInterval
          }
          spawnCountdown -= deltaTime
          
      }
      private func spawnBuddy(){
          
        let buddy = SpectrumShape(shape: shapeNode.shape, player: spawnerEntity!.playerComponent.player , size: Constants.Buddy.size )
          
        spawnerEntity!.buddies.append(buddy)
        buddy.position = shapeNode.position
        buddy.setUpCollisionAsBuddy()
        buddy.addToScene(spawnerEntity!.scene)
        buddy.startMoveAction(to: spawnerEntity!.focus)
          
      }
//     
}
