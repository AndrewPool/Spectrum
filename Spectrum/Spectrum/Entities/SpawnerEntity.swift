//
//  Spawner.swift
//  Spectrum
//
//  Created by Andrew Pool on 9/11/19.
//  Copyright © 2019 TokenResearch. All rights reserved.
//

import GameKit


//a spawner entity is an object that is composed of a spawner, the things it spawns, and also the controller functions/objects

class SpawnerEntity: GKEntity{
  
    //here are some properties
    override var description: String{
        guard let name = (component(ofType: PlayerComponent.self)?.player.name) else {return "failed description of spawner entity"}
        return name + "'s Spawner"
    }
  
    //grab weak pointers for the sweet cashe value
    
    //parent scene
    weak var scene: SpectrumScene!
    
    //internal components that alwasys exist
    weak var playerComponent: PlayerComponent!//there is a neutral player
    weak var shapeComponent: ShapeComponent!
    //internal components that might not exist
    //i might not use this
    weak var controlComponent: ControlComponent?
    weak var spawnerComponent: SpawnerComponent?
    
    //this is entity stuff, location and buddies
    var focus = CGPoint(x:0,y:0)
    
    
    //
    private var shape = Shape.Circle
    
    
    //---------------------init and set up
    
    //this becomes the designated init()
    init(scene:SpectrumScene, player: PlayerComponent, location: CGPoint) {
        
        let position = location
        self.scene = scene
        
        
        super.init()
        //sets up the required components
        //player
        addComponent(player)
        self.playerComponent = player
        
       
        //shape
        let shapeComponent = ShapeComponent(shape: shape, player: playerComponent.player, size: Constants.Spawner.size)
        addComponent(shapeComponent)
        self.shapeComponent = shapeComponent
        shapeComponent.shapeNode.position = position
        shapeComponent.shapeNode.addToScene(scene)
        
        shapeComponent.shapeNode.startPulseAction()
      
       
    }
    private func setShape(){
        
    }
   
 
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addSpawnerComponent(){
        //spawner
        guard spawnerComponent == nil else {return}
        let spawnerComponent = SpawnerComponent(
            spawnBuddyFunction: buddyForSpawner
        )
        addComponent(spawnerComponent)
        self.spawnerComponent = spawnerComponent
        scene.spawningSystem.addComponent(spawnerComponent)
        
    }
    func addControlComponent(){
        
        let controlComponentStart  = ControlComponent()
        addComponent(controlComponentStart)
        controlComponent=controlComponentStart
        
    }
    func addGameComponent(){
        
        
        let gameComponent = GameComponent(Constants.Spawner.hp , flavor: .spawner,player: playerComponent)
        addComponent(gameComponent)
        shapeComponent.shapeNode.gameComponent = gameComponent
        scene.gameSystem.addComponent(gameComponent)
        
    }

       //-----------------init and setup above
  
    //changeing people
    func configPlayer(){
        print("config")
        playerComponent = component(ofType: PlayerComponent.self)
        shapeComponent.shapeNode.configWithPlayer(player: playerComponent.player)
        shapeComponent.shapeNode.setUpCollisionAsSpawner()
        
    }
    
    //-------------update and helpers----------------------
  
}
