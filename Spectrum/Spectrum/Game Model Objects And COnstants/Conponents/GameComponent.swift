//
//  GameComponent.swift
//  Spectrum
//
//  Created by Andrew Pool on 9/30/19.
//  Copyright © 2019 TokenResearch. All rights reserved.
//

import GameKit

class GameComponent: GKComponent{
    
    var hp = 10
    
    func getStatsForCollision()->Int{
        return hp
    }
    
    //we can do some closure shit here
    func hit(attackValue: Int){
        hp -= attackValue
    }
    override func update(deltaTime seconds: TimeInterval) {
        
    }
    
    convenience init(_ hp:Int){
        
        self.init()
        self.hp = hp
    }
    override init(){
        
        super.init()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
