//
//  BuddyComponent.swift
//  Spectrum
//
//  Created by Andrew Pool on 9/30/19.
//  Copyright © 2019 TokenResearch. All rights reserved.
//
import GameKit

class BuddyComponent: GKComponent{
    
    weak var buddyEntity : BuddyEntity!//must set up imediatly
    weak var shapeNode : SpectrumShape!
  //  weak var gameComponent : GameComponent
    //-------------update and helpers----------------------
   
    private var strength:Scalar = 30.0
    private var strength2:Scalar = 60.0
    
    override func update(deltaTime seconds: TimeInterval) {
       doSomeThing()
        
    }
    
    private func doSomeThing(){

        guard let currentVelocity = shapeNode.physicsBody?.velocity else {return}

        let focus = Vector2(buddyEntity.owner.focus)
        
        let selfLocation = Vector2(shapeNode.position)
               
        let lineBetween = (focus - selfLocation).normalized()*strength
        
        let newVelocity = (Vector2(currentVelocity) + lineBetween).slowedTo(strength2)
           
        shapeNode.physicsBody?.velocity = (CGVector(dx: CGFloat(newVelocity.x), dy: CGFloat(newVelocity.y)))

    }
    

    func setEntity(){
        let parent = entity as! BuddyEntity
        buddyEntity = parent
        
    }
    
    
    
}
