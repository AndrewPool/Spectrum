//
//  GameComponent.swift
//  Spectrum
//
//  Created by Andrew Pool on 9/30/19.
//  Copyright © 2019 TokenResearch. All rights reserved.
//

import GameKit

//hardest part of programming right here.
//this will be replaced with a more functional paradigm
enum Flavor{
    case spawner
    case buddy
}

//this player shit is way too complicated
class GameComponent: GKComponent, GameCollisionProtocol{
   
    var maxhp = Constants.Spawner.hp
    var hp : Int
   
    var player: PlayerComponent
    var contextPlayer: PlayerComponent!
    //functional programming
    private var hitFunction:((PlayerComponent, Int)->Void)!
    private var attackFunction:((PlayerComponent)->Int)!
    private var passiveUpdate:(TimeInterval)->Void = {_ in }
    
    //
    func attack(player:PlayerComponent) -> Int {
        return attackFunction(player)
    }
    
    
    func hit(player: PlayerComponent,attack: Int){
        hitFunction(player, attack)
    }
    //here are some implementations of attack and hit functions
    private func buddyAttack(player:PlayerComponent)->Int{
        if(player==self.player){
            return 0
        }else{
            return hp
        }
    }
    private func spawnerAttack(player:PlayerComponent)->Int{
        if(player==self.player){
            return 0
        }else{
            return Constants.Spawner.hp
        }
    }
    private func spawnerHit(player: PlayerComponent,attack: Int){
        if let e = entity as? SpawnerEntity{
            if let sc = e.component(ofType: SpawnerComponent.self){
                sc.increment(by: Constants.Spawner.pulseSpeedInterval)
            }
        }
        
        if(player==contextPlayer){
            hp += attack
            if hp == Constants.Spawner.hp{
                if let e = entity as? SpawnerEntity {
                    e.removeComponent(ofType: PlayerComponent.self)
                    e.addComponent(player)
                    
                    if (entity?.component(ofType: ControlComponent.self)) == nil{
                        e.addControlComponent()
                           e.addSpawnerComponent()
                    }
                    
                    refresh()
                    //
                 
                    e.configPlayer()
                      print("spawner player transfer happened")
                }
            } }else {
                hp -= attack
                if(hp<0){
                    hp = 0
                    contextPlayer=player
                }
        }
    }
    private func buddyHit(player: PlayerComponent,attack: Int){
        hp -= attack
        if(hp<0){
            hp = 0
        }
        
    }
    private func refresh(){
        hp=Constants.Spawner.hp
    }
    override func update(deltaTime seconds: TimeInterval) {
        passiveUpdate(seconds)
    }
    private func spawerUpdate()->Void{
        print(hp)
               
    }
    ///iplentation fucntions above
    ///
    ///-----------init------------
    init(_ hp:Int, flavor: Flavor, player:PlayerComponent){
        
        self.hp = hp
        self.player = player
        contextPlayer = player
        super.init()
        switch flavor {
        case .buddy:
            hitFunction = buddyHit
            attackFunction = buddyAttack(player:)
            //passiveUpdate = {}
        case .spawner:
            hitFunction = spawnerHit
            attackFunction = spawnerAttack(player:)
            passiveUpdate = {_ in
                if let e = self.entity as? SpawnerEntity{
                    if let sc = e.component(ofType: SpawnerComponent.self){
                        self.hp = Int(((Double(self.maxhp) * Constants.Spawner.pulseSpeedInterval) - (sc.spawnCountdown))/Constants.Spawner.pulseSpeedInterval)
                        if(self.hp > self.maxhp){
                            self.hp = self.maxhp
                        }
                    }
                }
            }//print(hp)}
        }
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
