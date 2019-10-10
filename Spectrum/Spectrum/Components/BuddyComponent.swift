//
//  BuddyComponent.swift
//  Spectrum
//
//  Created by Andrew Pool on 9/30/19.
//  Copyright © 2019 TokenResearch. All rights reserved.
//
import GameKit

class BuddyComponent: GKComponent{
    
    let shapeNode : SpectrumShape
    weak var buddyEntity : BuddyEntity!//must set up imediatly
  //  weak var gameComponent : GameComponent
    //-------------update and helpers----------------------
   
    private var strength = 1.0
    private var strength2 = 50.0
    
    override func update(deltaTime seconds: TimeInterval) {
       doSomeThing()
        
    }
    
    private func doSomeThing(){

        let currentVelocity = shapeNode.physicsBody?.velocity

        let currentUpdatedVelocity = pushToFocus(Vector2(currentVelocity!))
        
       // let slowed = slowToSpeedLimit(currentUpdatedVelocity)
        
       
       // let padded = lineBetween - (-lineBetween / 4)
        
        //let scalar : Scalar = 1.0
        
        
       // let otherVector = Vector2(
        shapeNode.physicsBody?.applyImpulse(CGVector(dx: CGFloat(currentUpdatedVelocity.x), dy: CGFloat(currentUpdatedVelocity.y)))
      
        shapeNode.physicsBody?.velocity = CGVector(slowToSpeedLimit2(Vector2((shapeNode.physicsBody?.velocity)!)))
    }
    private func pushToFocus(_ vector2:Vector2)->Vector2{
        let focus = Vector2(buddyEntity.owner.focus)
        let selfLocation = Vector2(shapeNode.position)
        
        
         let lineBetween = (focus - selfLocation)
        
       //let lineBetweenAdjusted = lineBetween/(lineBetween.length)
        
        
        
     // if(a)
        
        return lineBetween//Adjusted
    }
    private func slowToSpeedLimit(_ v2:Vector2)->Vector2{
        //
        print("\(v2.length) before")
        let length = v2.length
        if ( length > Scalar(strength)){
           // print("happeenend!")
            let new = v2 * (100 / -(Scalar(strength) - length))
             print("\(new.length) after")
            return new
            
        }
        
        
        return v2
    }
    private func slowToSpeedLimit2(_ v2:Vector2)->Vector2{
        //
        print("\(v2.length) before")
        let length = v2.length
        if ( length > Scalar(strength2)){
            print("happeenend!")
            let new = v2 * (100 / -(Scalar(strength2) - length))
             print("\(new.length) after")
            return new
            
        }
        
        
        return v2
    }
    
    
    
    
    
    
    
    //------------init and set up-----------------
      convenience init(shape: Shape, player:Player, size:Int, scene:SpectrumScene){
          
          let shape = SpectrumShape(shape: shape, player: player, size: size)
          
          self.init(shape, scene)
      }
      
      init(_ spectrumShape:SpectrumShape,_ scene:SpectrumScene){
          
          shapeNode = spectrumShape
          
          super.init()
          //this is gross but i mean what can you do
          
         
          
      }
      func setEntity(){
          let parent = entity as! BuddyEntity
          buddyEntity = parent
          
      }
      
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
