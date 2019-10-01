//
//  GameComponent.swift
//  Spectrum
//
//  Created by Andrew Pool on 9/30/19.
//  Copyright © 2019 TokenResearch. All rights reserved.
//

import GameKit

class GameComponent: GKComponent{
    
    var hp = 10{
        didSet{
            if hp<0{
                if let deleteable = entity as? Deletable{
                    deleteable.delete()
                }
            }
        }
    }
    
    func getStatsForCollision()->Int{
        return hp
    }
    
    //we can do some closure shit here
    func hit(attackValue: Int){
        hp -= attackValue
    }
   
}
