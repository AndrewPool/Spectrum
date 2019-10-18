//
//  Game.swift
//  Spectrum
//
//  Created by Andrew Pool on 10/15/19.
//  Copyright © 2019 TokenResearch. All rights reserved.
//

import Foundation
import GameplayKit

struct Game{
   //multitouch stuff

    var selectedControlDelegates = [UITouch:ControlDelegate]()
       
    //entities
    var spawningSystem = GKComponentSystem(componentClass: SpawnerComponent.self)
    var gameSystem = GKComponentSystem(componentClass: GameComponent.self)
    
    
    var spawnerEntities = [SpawnerEntity]()
    var buddyEntities = [BuddyEntity]()
    
    var node = SKNode()
    //dt upadte stuff
    var lastUpdateTime : TimeInterval = 0
    
    var spawnInterval = Constants.Spawner.pulseSpeedInterval
    
    let buddypulseInterval = Constants.Spawner.pulseSpeedInterval/2
    
    var buddypulseIntervalCount = Constants.Spawner.pulseSpeedInterval
    
    var playing = false
    
    var over : Bool {
        guard spawnerEntities.count > 0, let player = spawnerEntities[0].playerComponent else{return true}
        
        for e in 1..<spawnerEntities.count{
            if spawnerEntities[e].playerComponent.player.physicsKey != player.player.physicsKey && spawnerEntities[e].playerComponent.player.computer == false{
                return  false
                
                
            }
        }
        return true
    }
    
    mutating func newGame(){
        
        print("new game")
        for child in node.children{
                     
                     child.run(SKAction.fadeOut(withDuration: 2.0)){
                         child.removeFromParent()
            }
        }
        playing = false
        
     
        
        for s in spawnerEntities{
            spawningSystem.removeComponent(foundIn: s)
            gameSystem.removeComponent(foundIn: s)
        }
        
        for b in buddyEntities{
            spawningSystem.removeComponent(foundIn: b)
            gameSystem.removeComponent(foundIn: b)
        }
        buddyEntities = []
        spawnerEntities = []
        
        spawningSystem = GKComponentSystem(componentClass: SpawnerComponent.self)
        gameSystem = GKComponentSystem(componentClass: GameComponent.self)
        
    }
}
