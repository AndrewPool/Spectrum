//
//  BuddySpawnerHelper.swift
//  Spectrum
//
//  Created by Andrew Pool on 10/10/19.
//  Copyright © 2019 TokenResearch. All rights reserved.
//

import Foundation
import GameKit

extension SpawnerEntity {
    
    func buddyForSpawner()->Void{
        //
        let buddy = BuddyEntity(owner: self)
        scene.buddyEntities.append(buddy)
        
        let buddyComponent = BuddyComponent()//shape: shapeComponent.shapeNode.shape, player: playerComponent.player, size: Constants.Buddy.size , scene: scene)
        buddy.addComponent(buddyComponent)
        
        buddyComponent.setEntity()
      
        let gameComponent = GameComponent(10)
        buddy.addComponent(gameComponent)
        scene.gameSystem.addComponent(gameComponent)
        
        let newShapeComponent = ShapeComponent(shape: .Circle, player: playerComponent.player, size: Constants.Buddy.size)
        
        newShapeComponent.shapeNode.position = shapeComponent.shapeNode.position
        newShapeComponent.shapeNode.setUpCollisionAsBuddy()
        newShapeComponent.shapeNode.addToScene(scene)
        newShapeComponent.shapeNode.startMoveAction(to: focus)
        newShapeComponent.shapeNode.gameComponent = gameComponent
        buddy.addComponent(newShapeComponent)
        
        buddyComponent.shapeNode = newShapeComponent.shapeNode
        buddyComponent.shapeNode.gameComponent = gameComponent
        
     
        buddy.owner = self
    }
    
}
