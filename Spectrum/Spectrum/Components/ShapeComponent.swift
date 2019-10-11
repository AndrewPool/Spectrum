//
//  ShapeComponent.swift
//  Spectrum
//
//  Created by Andrew Pool on 10/10/19.
//  Copyright © 2019 TokenResearch. All rights reserved.
//

import GameKit

class ShapeComponent: GKComponent{
    
    
    let shapeNode : SpectrumShape
    
       //sweet cache value
    //weak var spawnerEntity : SpawnerEntity!
        //weak var scene : SpectrumScene!
    
    //this is so that the collisiono can do functions and shit
    //   weak var gameSystem : GKComponentSystem<GameComponent>!
        
    
    //------------init and set up-----------------
    convenience init(shape: Shape, player:Player, size:Int//,
                   //  scene:SpectrumScene
    ){
       
        let shape = SpectrumShape(shape: shape, player: player, size: size)
        
        self.init(shape
            //, scene
        )
    }
    
    init(_ spectrumShape:SpectrumShape
        //,_ scene:SpectrumScene
    ){
     
        shapeNode = spectrumShape
      
        super.init()
        //this is gross but i mean what can you do
       
        shapeNode.setUpCollisionAsSpawner()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
