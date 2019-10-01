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
  
    //grab a weak pointers for the sweet cashe value
    //parent scene
    weak var scene: SpectrumScene!
    //internal components
    weak var playerComponent: PlayerComponent!
    weak var controlComponent: ControlComponent?
    weak var spawnerComponent: SpawnerComponent!
  
   
   // var spawner : SpectrumShape
    
    
    //this is entity stuff, location and buddies
    var focus = CGPoint(x:100,y:100)

    var buddies = [SpectrumShape]()
    
    
    //
    private var shape = Shape.Circle
    
   
    //---------------------init and set up
    
    //this becomes the designated init()
    init(scene:SpectrumScene, player: Player, location: CGPoint) {
        
        let position = location
        self.scene = scene
        
        //  focus = SpectrumShape(shape: shape, player: player, size: Constants.Spawner.Focus.size)
        super.init()
        
        
        let spawnerComponent = SpawnerComponent(shape: shape, player:player, size:Constants.Spawner.size, scene: scene)
        addComponent(spawnerComponent)
        self.spawnerComponent = spawnerComponent
        spawnerComponent.shapeNode.position = position
        spawnerComponent.shapeNode.addToScene(scene)
        scene.spawningSystem.addComponent(spawnerComponent)
        
        
        
        let playerComponent = PlayerComponent(player: player)
        addComponent(playerComponent)
        self.playerComponent = playerComponent
        
        let controlComponentStart  = ControlComponent(controler: self)
        addComponent(controlComponentStart)
        controlComponent=controlComponentStart
        
        
        // focus.addToScene(scene)
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
//
//    private func tryToSpawn(deltaTime: TimeInterval){
//        if (spawnCountdown <= 0){
//            spawnBuddy()
//           spawnCountdown += Constants.Spawner.spawnInterval
//        }
//        spawnCountdown -= deltaTime
//
//    }
//    private func spawnBuddy(){
//
//        let buddy = SpectrumShape(shape: shape, player: component(ofType: PlayerComponent.self)!.player , size: Constants.Buddy.size )
//
//        buddies.append(buddy)
//        buddy.position = spawnerComponent.shapeNode.position
//        buddy.setUpCollisionAsBuddy()
//        buddy.addToScene(scene)
//        buddy.startMoveAction(to: focus)
//
//    }
//
   //---collision and shit

  
}
