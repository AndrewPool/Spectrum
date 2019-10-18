//
//  Constants.swift
//  Spectrum
//
//  Created by Andrew Pool on 9/11/19.
//  Copyright © 2019 TokenResearch. All rights reserved.
//

import Foundation
import GameKit


struct Constants{
    
    static let computerNames = ["Hal 9000", "Terminator", "CeeThreePeeOh","Data"]
    
    struct GameSceen {
        static let FadeOutDuration = 2.0
           struct Focus {
               static let leftSideFile = "LeftSideScreenFocusEmitter.sks"
               static let rightSideFile = "RightSideScreenFocusEmitter.sks"
               static let topSideFile = "TopSideScreenFocusEmitter.sks"
               static let bottomSideFile = "BottomSideScreenFocusEmitter.sks"
           }
       }
      
    struct Spawner {
        static let pulseSpeedInterval = 2.0
        static let pulseSizeScale = CGFloat(1.2)
        
        //static let spawnInterval = 2.0;
        static let size = 100;
        static let hp = 10
        struct Focus{
               static let size = 10
               static let emitterFile = "FocusFire.sks"
               static let emitterName = "Focus Fire"
           
           }
    }
    
    struct UI{
        static let GoArrowImageName = "GoArrow.png"
        static let TargetImageName = "Target.png"
    }
    
    struct Buddy {
        static let size = 20
    }
    
    struct Layers {
        static let background = 0
        static let scene = 1
        static let enemies = 2
        static let player = 3
        static let emmiters = 4
        static let topLayer = 10//yep
    }
    
    //this can be procedrual with more players.
    enum Collision : UInt32{
        case neutral = 1
        case playerASpawner = 2
        case playerABuddies = 4
        case playerBSpawner = 8
        case playerBBuddies = 16
    }
    
    
}

enum PhysicsKey{
    case neutral
    case player1
    case player2
    
    
    //configured so that buddies call collision on buddies of the same team, and also enemies
    // neutral doesn't call collisoin on self? idk could use some work.
        
    //for spawner
    func setupCollisionParamaters(spawner:SKPhysicsBody){
        spawner.restitution = 1
               spawner.friction = 0
               spawner.allowsRotation = false
        switch self{
        case .neutral:
            spawner.categoryBitMask = Constants.Collision.neutral.rawValue
            spawner.collisionBitMask =
                
                Constants.Collision.playerABuddies.rawValue |
                
                Constants.Collision.playerBBuddies.rawValue
            
            spawner.contactTestBitMask =
                Constants.Collision.playerABuddies.rawValue |
                
                Constants.Collision.playerBBuddies.rawValue
            
            
        case .player1:
            spawner.categoryBitMask = Constants.Collision.playerASpawner.rawValue
            spawner.collisionBitMask =
                Constants.Collision.playerBBuddies.rawValue
            
            spawner.contactTestBitMask =
                Constants.Collision.playerBBuddies.rawValue
            
        case .player2:
            spawner.categoryBitMask = Constants.Collision.playerBSpawner.rawValue
            spawner.collisionBitMask =
                Constants.Collision.playerABuddies.rawValue
            
            spawner.contactTestBitMask =
                Constants.Collision.playerABuddies.rawValue
            
        }
    }
    //for buddies
    func setupCollisionParamaters(buddy:SKPhysicsBody){
        buddy.restitution = 0.1
        buddy.friction = 0.1
        buddy.allowsRotation = false
        switch self{
        case .neutral:
            buddy.categoryBitMask = Constants.Collision.neutral.rawValue
            buddy.collisionBitMask =
                
                Constants.Collision.playerABuddies.rawValue |
                
                Constants.Collision.playerBBuddies.rawValue
            
            buddy.contactTestBitMask =
                Constants.Collision.playerABuddies.rawValue |
                
                Constants.Collision.playerBBuddies.rawValue
            
        case .player1:
            buddy.categoryBitMask = Constants.Collision.playerABuddies.rawValue
            buddy.collisionBitMask =
                Constants.Collision.playerABuddies.rawValue
                
            buddy.contactTestBitMask =
                Constants.Collision.playerBBuddies.rawValue |
                Constants.Collision.playerBSpawner.rawValue
            
        case .player2:
            buddy.categoryBitMask = Constants.Collision.playerBBuddies.rawValue
            
            buddy.collisionBitMask =
                Constants.Collision.playerBBuddies.rawValue |
              Constants.Collision.playerASpawner.rawValue
            
            buddy.contactTestBitMask =
                Constants.Collision.playerABuddies.rawValue |
                Constants.Collision.playerASpawner.rawValue
            
        }
        
    }
}


