//
//  SceneControlNode.swift
//  Spectrum
//
//  Created by Andrew Pool on 10/17/19.
//  Copyright © 2019 TokenResearch. All rights reserved.
//

import GameKit

class SceneControlNode:SKNode, ControlDelegate{
    var selected: Bool = false
    
     var gameScene : SpectrumScene
       
       //
       init(_ scene:SpectrumScene){
           self.gameScene = scene
           super.init()
           // addLabel()
           
       }
       
       required init?(coder aDecoder: NSCoder) {
           fatalError("init(coder:) has not been implemented")
       }
       
    
    func touchesBegan(touches: Set<UITouch>) {
        
    }
    
    func touchesMoved(touches: Set<UITouch>) {
    
    }
    
    func touchesEnded(touches: Set<UITouch>) {
        
    }
    
    func touchesCancelled(touches: Set<UITouch>) {
        
    }
    

}
