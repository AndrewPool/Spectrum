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
class SpawnerEntity: GKEntity, ControlDelegate{
    
    override var description: String{
        return "\(player.name)'s Spawner"
    }
  
    //grab a weak copy of it's parent for putting things in
    weak var scene: SpectrumScene!
    
    
    
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
    
    private var player = Player()
    
    private var spawnCountdown = 0.0
    
 
    //var spawnBuddy : (_ player:Player)->Void
    
    
    
    //---------------------init and set up functions------------------------
    
    
    //this becomes the designated() init
    init(scene:SpectrumScene, player: Player) {
        
        self.scene = scene
        
        spawner = SpectrumShape(shape: shape, player:player, size:Constants.Spawner.size)
        
      //  focus = SpectrumShape(shape: shape, player: player, size: Constants.Spawner.Focus.size)
        super.init()
        
        spawner.position.x = CGFloat(100)
        
        spawner.setUpCollisionAsSpawner()
        spawner.controlDelegate = self
        print(spawner.controlDelegate as! CustomStringConvertible)
        spawner.addToScene(scene)
     
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
        let buddy = SpectrumShape(shape: shape, player: player , size: Constants.Buddy.size )
        buddies.append(buddy)
        buddy.position = spawner.position
          buddy.setUpCollisionAsBuddy()
        buddy.addToScene(scene)
        buddy.startMoveAction(to: focus)
        
    }
   
   //---collision and shit

    
    // -------------------COntrol Delegate Functions, and helper functions--------------------
      
      func touchesBegan(touches: Set<UITouch>) {
          
      }
      
      func touchesMoved(touches: Set<UITouch>) {
          
      }
      
      func touchesEnded(touches: Set<UITouch>) {
        print("Spawner Control Delegate happened")
       // scene.controlDelegate = self
      }
      
      func touchesCancelled(touches: Set<UITouch>) {
          
      }
      

    // ------------------Control Delegate Functions, and helper FUncstoins above------------------------
}
