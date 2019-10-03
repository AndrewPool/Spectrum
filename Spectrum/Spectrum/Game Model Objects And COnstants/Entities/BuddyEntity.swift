//
//  BuddyEntity.swift
//  Spectrum
//
//  Created by Andrew Pool on 9/30/19.
//  Copyright © 2019 TokenResearch. All rights reserved.
//

import GameKit

class BuddyEntity: GKEntity, Deletable{
    
    
    weak var owner : SpawnerEntity!
   
    
    init(owner:SpawnerEntity){
        super.init()
        self.owner = owner
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func delete(){
        
        
        
      
        if let buddyComponent = component(ofType: BuddyComponent.self){
            buddyComponent.shapeNode.removeFromParent()
        }
       
    }
}

