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
    weak var spawnerEntity : SpawnerEntity!
    weak var scene : SpectrumScene!
    
    private var spawnCountdown = 0.0
    
    
    //-------------update and helpers----------------------
    override func update(deltaTime seconds: TimeInterval) {
        tryToSpawn(deltaTime:seconds)
    }
    
    private func tryToSpawn(deltaTime: TimeInterval){
        if (spawnCountdown <= 0){
            spawnBuddy()
            spawnCountdown += Constants.Spawner.pulseSpeedInterval
        }
        spawnCountdown -= deltaTime
        
    }
    
    private func spawnBuddy(){
        
        //
        let buddy = BuddyEntity(owner: spawnerEntity)
        spawnerEntity.buddies.append(buddy)
        
//
        let buddyComponent = BuddyComponent(shape: shapeNode.shape, player: spawnerEntity!.playerComponent.player, size: Constants.Buddy.size , scene: scene)

        
        buddyComponent.shapeNode.position = shapeNode.position
        buddyComponent.shapeNode.setUpCollisionAsBuddy()
        buddyComponent.shapeNode.addToScene(spawnerEntity!.scene)
        buddyComponent.shapeNode.startMoveAction(to: spawnerEntity!.focus)
        
        buddy.addComponent(buddyComponent)
        
    }
    //----------------update above----------------------------
    
    
    
    //------------init and set up-----------------
    convenience init(shape: Shape, player:Player, size:Int, scene:SpectrumScene){
        
        let shape = SpectrumShape(shape: shape, player: player, size: size)
        
        self.init(shape, scene)
    }
    
    init(_ spectrumShape:SpectrumShape,_ scene:SpectrumScene){
        self.scene = scene
        
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
}
