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
        
        let aGameComp = a.gameComponent!// as? GameCollisionProtocol
        let bGameComp = b.gameComponent! //as! GameCollisionProtocol
        
        //only need to cache the first one, not both
        let aAttack = aGameComp.attack()
        let aPlayer = aGameComp.player()
        
        aGameComp.hit(player: bGameComp.player(), attack: bGameComp.attack())
        bGameComp.hit(player: aPlayer, attack: aAttack)
    }
    
}
