//
//  BuddyComponent.swift
//  Spectrum
//
//  Created by Andrew Pool on 9/30/19.
//  Copyright © 2019 TokenResearch. All rights reserved.
//
import GameKit

class BuddyComponent: GKComponent{
    
    //cache value,! note the weakness! don't make this mistake!
    weak var shapeNode : SpectrumShape!
 
    //-------------update and helpers----------------------
   
    //TODO move somewhere else
    private var strength:Scalar = 40.0
    private var strength2:Scalar = 60.0
   // private let randomFactor = 0.9...0.1
    
    override func update(deltaTime seconds: TimeInterval) {
       doSomeThing()
        
    }
    
    private func doSomeThing(){

        guard let currentVelocity = shapeNode.physicsBody?.velocity else {return}
       
        let focus = Vector2(buddyEntity().owner.focus)
        
        let selfLocation = Vector2(shapeNode.position)
               
        let lineBetween = (focus - selfLocation).normalized()*strength
        
        let newVelocity = (Vector2(currentVelocity) + lineBetween).slowedTo(strength2)
        
        let randomized = Vector2(x: newVelocity.x*Float.random(in: 0.9...1.1), y: newVelocity.y*Float.random(in: 0.9...1.1))
        
        
        shapeNode.physicsBody?.velocity = (CGVector(dx: CGFloat(randomized.x), dy: CGFloat(randomized.y)))

    }
    

    
    
    
    
}
