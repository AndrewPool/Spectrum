//
//  StartGameDelegate.swift
//  Spectrum
//
//  Created by Andrew Pool on 9/23/19.
//  Copyright © 2019 TokenResearch. All rights reserved.
//

import Foundation
import GameKit
//this is the delegate for the start of the game, basilcly,it's a bunch of code, so that we don't have to constantly bechecking the game state
class StartUpDelegate:ControlDelegate{
    
    var selected = false
    weak var gameScene : SpectrumScene?
    
    init(scene:SpectrumScene){
        self.gameScene = scene
    }
    
    func touchesBegan(touches: Set<UITouch>) {
      print("touchesBegan Delegate called")
        gameScene!.setUpGame()
                
    }
    
    func touchesMoved(touches: Set<UITouch>) {
     
    }
    
    func touchesEnded(touches: Set<UITouch>) {
       
    }
    
    func touchesCancelled(touches: Set<UITouch>) {
     
    }
    
  
    
}
