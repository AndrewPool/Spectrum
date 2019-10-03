//
//  Spawner.swift
//  Spectrum
//
//  Created by Andrew Pool on 9/11/19.
//  Copyright © 2019 TokenResearch. All rights reserved.
//

import GameKit


//a spawner entity is an object that is composed of a spawner, the things it spawns, and also the controller functions/objects

/*
todo the buddies ned to be entities too, right now the are just controlled by this entirity, kinda negating the purpose in the first place
 */

//right now it is only good for a circle
class SpawnerEntity: GKEntity{
  
    //here are some properties
    override var description: String{
        guard let name = (component(ofType: PlayerComponent.self)?.player.name) else {return "failed description"}
        return name + "'s Spawner"
    }
  
    //grab weak pointers for the sweet cashe value
    
    //parent scene
    weak var scene: SpectrumScene!
    
    //internal components that alwasys exist
    weak var playerComponent: PlayerComponent!//there is a neutral player
    weak var spawnerComponent: SpawnerComponent!
    //weak var radioComponent: RadioComponent!
    //internal components that might exist
    weak var controlComponent: ControlComponent?
    
    
    //to be componented
    
  
    //this is entity stuff, location and buddies
    var focus = CGPoint(x:100,y:100)

    
    //
    private var shape = Shape.Circle
    
   
    //---------------------init and set up
    
    //this becomes the designated init()
    init(scene:SpectrumScene, player: Player, location: CGPoint) {
        
        let position = location
        self.scene = scene
        
      
        super.init()
        
        
        let spawnerComponent = SpawnerComponent(shape: shape, player:player, size:Constants.Spawner.size, scene: scene)
        addComponent(spawnerComponent)
        self.spawnerComponent = spawnerComponent
        spawnerComponent.shapeNode.position = position
        spawnerComponent.shapeNode.addToScene(scene)
        scene.spawningSystem.addComponent(spawnerComponent)
        spawnerComponent.shapeNode.startPulseAction()
        
        spawnerComponent.gameSystem = (scene.gameSystem as! GKComponentSystem<GameComponent>)
        
        
        let playerComponent = PlayerComponent(player: player)
        addComponent(playerComponent)
        self.playerComponent = playerComponent
        
        let controlComponentStart  = ControlComponent(controler: self)
        addComponent(controlComponentStart)
        controlComponent=controlComponentStart
        
        let gameComponent = GameComponent(100)
        addComponent(gameComponent)
        spawnerComponent.shapeNode.gameComponent = gameComponent
        scene.gameSystem.addComponent(gameComponent)
        
       
    }
   
 
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUp(){
        spawnerComponent.setEntity()
    }
    
       //-----------------init and setup above
  
    
    
    //-------------update and helpers----------------------
    override func update(deltaTime seconds: TimeInterval) {
        
        //tryToSpawn(deltaTime:seconds)
    }

}