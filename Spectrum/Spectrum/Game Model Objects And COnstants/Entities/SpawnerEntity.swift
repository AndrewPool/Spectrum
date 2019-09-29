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
    
    override var description: String{
        
        guard let name = (component(ofType: PlayerComponent.self)?.player.name) else {return "failed description"}
        return name + "'s Spawner"
    }
  
    //grab a weak pointers for the sweet cashe value
    weak var scene: SpectrumScene!
    weak var playerComponent: PlayerComponent!
    weak var controlComponent: ControlComponent?
    
    //here are some properties
    
    //this is for the ControlDelegate
    var selected = false {didSet{   if(selected){ scene.addChild(focusFire) } else{focusFire.removeFromParent()}}  }
    
    //here are the various SKNodes
    lazy var focusFire : SKEmitterNode = {
        let focusFire = SKEmitterNode(fileNamed: "FocusFire.sks")!
        focusFire.targetNode = spawner
        focusFire.name = "Focus Fire"
        return focusFire

    }()
    var spawner : SpectrumShape
    
    var focus = CGPoint(x:100,y:100)

    var buddies = [SpectrumShape]()
    
    
    //
    private var shape = Shape.Circle
    
   
    
    private var spawnCountdown = 0.0
    
 
    //var spawnBuddy : (_ player:Player)->Void
    
    
    
    //---------------------init and set up functions------------------------
    
    
    //this becomes the designated() init
    init(scene:SpectrumScene, player: Player) {
        
   
        self.scene = scene
        
        spawner = SpectrumShape(shape: shape, player:player, size:Constants.Spawner.size)
        
              
           
           spawner.position.x = CGFloat(100)
           
           spawner.setUpCollisionAsSpawner()
          
        
          
         
           spawner.addToScene(scene)
      //  focus = SpectrumShape(shape: shape, player: player, size: Constants.Spawner.Focus.size)
        super.init()
        
        let playerComponent = PlayerComponent(player: player)
           addComponent(playerComponent)
           
        let controlComponentStart  = ControlComponent(controler: self)
                addComponent(controlComponentStart)
                controlComponent=controlComponentStart
     
     
       // focus.addToScene(scene)
    }
   
 
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
       //-----------------init and setup above
  
    
    
    //-------------update and helpers----------------------
    override func update(deltaTime seconds: TimeInterval) {
        
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
        
        let buddy = SpectrumShape(shape: shape, player: component(ofType: PlayerComponent.self)!.player , size: Constants.Buddy.size )
        
        buddies.append(buddy)
        buddy.position = spawner.position
          buddy.setUpCollisionAsBuddy()
        buddy.addToScene(scene)
        buddy.startMoveAction(to: focus)
        
    }
   
   //---collision and shit

  
}
