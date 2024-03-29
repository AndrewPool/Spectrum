//
//  VisualComponent.swift
//  Spectrum
//
//  Created by Andrew Pool on 9/28/19.
//  Copyright © 2019 TokenResearch. All rights reserved.
//

import GameKit

class SpawnerComponent: GKComponent{
    
   
   //sweet sweet functional programing
    var spawnBuddy: (()->Void)!
    
    public var spawnCountdown = 0.0
    
    public func increment(by amount:Double){
        spawnCountdown += amount
    }
    
    //-------------update and helpers----------------------
    override func update(deltaTime seconds: TimeInterval) {
        tryToSpawn(deltaTime:seconds)
    }
    
    private func tryToSpawn(deltaTime: TimeInterval){
        if (spawnCountdown < 0){
            spawnBuddy()
            spawnCountdown += Constants.Spawner.pulseSpeedInterval
        }
        spawnCountdown -= deltaTime
        
    }
    
    //----------------update above----------------------------
    
    
    
    //------------init and set up-----------------
    convenience init( spawnBuddyFunction: @escaping ()->Void){
       
       
        self.init(spawnBuddyFunction)
    }
    
    init(_ spawnBuddyFunction: @escaping ()->Void){
    
        spawnBuddy = spawnBuddyFunction
      
        super.init()
    
        
    }
  
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
     
    
}
