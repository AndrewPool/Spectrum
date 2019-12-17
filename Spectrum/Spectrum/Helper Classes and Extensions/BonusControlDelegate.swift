//
//  BonusControlDelegate.swift
//  Spectrum
//
//  Created by Andrew Pool on 12/14/19.
//  Copyright © 2019 TokenResearch. All rights reserved.
//

import GameKit

struct BonusControlDelegate:ControlDelegate{
    var selected: Bool
    let player:PlayerComponent
    let scene:SpectrumScene
  
    func touchesBegan(touches: Set<UITouch>) {
        
        print("spectrum scene self control delegate touchesBegan()")
        if let touch = touches.first{
            let location = touch.location(in: scene)
            for spawner in scene.game.spawnerEntities{
                if(spawner.playerComponent==player){
                    if  let cc = spawner.controlComponent {
                        // ( spawner.playerComponent.player.physicsKey == currentPlayer.player.physicsKey) &&
                        
                        if (!cc.selected && cc.target.contains(location)){
                            
                            cc.selected = true
                            
                            if  scene.game.selectedControlDelegates[touch] != nil {
                                scene.game.selectedControlDelegates[touch]?.append(cc)
                            } else {
                                scene.game.selectedControlDelegates[touch] = [cc]
                            }
                            //controlDelegate = spawner.controlComponent
                            //only do all per tap!
                        }
                    }
                    
                }
            }
        }
    }
    func touchesMoved(touches: Set<UITouch>) {
        
    }
    
    func touchesEnded(touches: Set<UITouch>) {
        for touch in touches{
            scene.game.selectedControlDelegates[touch]=nil
        }
    }
    
    func touchesCancelled(touches: Set<UITouch>) {
          for touch in touches{
            scene.game.selectedControlDelegates[touch]=nil
                     }
    }
    
    
   
    
}
