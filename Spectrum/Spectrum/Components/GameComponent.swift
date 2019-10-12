//
//  GameComponent.swift
//  Spectrum
//
//  Created by Andrew Pool on 9/30/19.
//  Copyright © 2019 TokenResearch. All rights reserved.
//

import GameKit

class GameComponent: GKComponent, GameCollisionProtocol{
    
    var hp = 10
    
    var contextPlayer: PlayerComponent!
    
    func attack() -> Int {
        return hp
    }
    func player() -> PlayerComponent {

        return (entity?.component(ofType: PlayerComponent.self)!)!
    }
    
    //we can do some closure shit here
    func hit(player: PlayerComponent,attack: Int){
        
        hp -= attack
        if(hp<0){
            hp = 0
        }
    }
    private func getPlayerComponent()->PlayerComponent{
        return ((entity?.component(ofType: PlayerComponent.self))!)
    }
    override func update(deltaTime seconds: TimeInterval) {
        //print(hp)
        
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
