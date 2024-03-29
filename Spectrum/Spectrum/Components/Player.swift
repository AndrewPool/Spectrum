//
//  Player.swift
//  Spectrum
//
//  Created by Andrew Pool on 9/11/19.
//  Copyright © 2019 TokenResearch. All rights reserved.
//

//import Foundation
import UIKit
import GameKit

//player component should never call entity! because it has multiple entities!
//It is also stashed on the scene! so it never goes away!
class PlayerComponent: GKComponent{
    //enforces the never call entity rule
    override var entity: GKEntity? {get{nil}}
    
    let player : Player
    
    init(player:Player) {
        self.player=player
        super.init()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

struct Player{
    let neutral:Bool
    let physicsKey:PhysicsKey
    let computer:Bool
    let name:String
    let color:UIColor//will be texture one day
    init( name:String, key:PhysicsKey, color:UIColor){
        neutral = false
        self.color = color
        computer = false
        self.name = name
        physicsKey = key
    }
    init(){
        neutral = true
        color = UIColor.orange
        computer = true
        physicsKey = PhysicsKey.neutral
        name = Constants.computerNames.randomElement()!
    }
    init(name:String, key:PhysicsKey){
        self.init(name:name, key:key, color:UIColor.blue)
    }

}
