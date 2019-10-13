//
//  GameUIControlDelegate.swift
//  Spectrum
//
//  Created by Andrew Pool on 10/12/19.
//  Copyright © 2019 TokenResearch. All rights reserved.
//

import GameKit

extension SpectrumScene{//:UISceneDelegate
    
    
    //-----------------touches and stuff below------------
    
    
    //these are called by the game engine, we might one day do event type checking here and what not, but right now it passes on the touch along with the scene to the delegate, and the delegate does what it wants, in the context
    // the first context is the StartUpDelegate one that's only implementation is that when touch begins, it calls gameScene.setUpGame()
    // we may or maynot require something something something
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        print("touchesBegan")
        
        if (controlDelegate != nil){
            controlDelegate!.touchesBegan(touches: touches)
            
        }
        
        
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if (controlDelegate != nil){controlDelegate!.touchesMoved(touches: touches)}
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if (controlDelegate != nil){controlDelegate!.touchesEnded(touches: touches)}
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        if (controlDelegate != nil){controlDelegate!.touchesCancelled(touches: touches)}
    }
    
    
    
    //-----------------touches and helpers and ControlDelegate above--------------
    
}
