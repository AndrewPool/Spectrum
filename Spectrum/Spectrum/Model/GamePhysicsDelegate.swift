//
//  GamePhysicsDelegate.swift
//  Spectrum
//
//  Created by Andrew Pool on 10/10/19.
//  Copyright © 2019 TokenResearch. All rights reserved.
//

import Foundation
import GameKit

class GamePhysicsDelegate: NSObject, SKPhysicsContactDelegate {

    func didBegin(_ contact: SKPhysicsContact) {
        
        guard let  a = contact.bodyA.node as? SpectrumShape else {return}
        guard let  b = contact.bodyB.node as? SpectrumShape else {return}
//        print(a)
//        print(b)
         let aPlayer = a.gameComponent!.player
         let bPlayer = b.gameComponent!.player 
              
       
        //only need to cache the first one, not both
        let aAttack = a.gameComponent!.attack(player: bPlayer)
        let bAttack = b.gameComponent!.attack(player: aPlayer)
        
        a.gameComponent!.hit(player: bPlayer, attack: bAttack)
        b.gameComponent!.hit(player: aPlayer, attack: aAttack)
    }
  
}
