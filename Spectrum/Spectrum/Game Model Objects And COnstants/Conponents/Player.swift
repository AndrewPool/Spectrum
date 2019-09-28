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

class PlayerConponent: GKComponent{
    
    var player : Player
    
    init(player:Player) {
        self.player=player
        super.init()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

struct Player{
   
    let physicsKey:PhysicsKey
    let computer:Bool
    let name:String
    let color:UIColor
    init(){
        color = UIColor.orange
        computer = true
        physicsKey = PhysicsKey.neutral
        name = Constants.computerNames.randomElement()!
    }
    init(name:String, key:PhysicsKey){
        color = UIColor.blue
        computer = false
        self.name = name
        physicsKey = key
    }
    

    
    
}
