//
//  ControlComponent.swift
//  Spectrum
//
//  Created by Andrew Pool on 9/28/19.
//  Copyright © 2019 TokenResearch. All rights reserved.
//

import GameKit

//this currently can only be owned by the spawner entity
class ControlComponent: GKComponent,ControlDelegate{
    
    var selected: Bool = false
    {didSet{if(selected){spawnerEntity().scene.addChild(focusFire) } else{focusFire.removeFromParent()}  }}
    
   
    //here are the various SKNodes
    lazy var focusFire : SKEmitterNode = {
        
        let focusFire = SKEmitterNode(fileNamed: "FocusFire.sks")!
        focusFire.particleColor = spawnerEntity().playerComponent.player.color
        focusFire.particleColorSequence = nil
        focusFire.zPosition = CGFloat(Constants.Layers.background)
        focusFire.name = "Focus Fire"
        return focusFire
        
    }()
    
    

    //
    
    //---------delegate controls below
    func touchesBegan(touches: Set<UITouch>) {
        //print("Component TD")
        guard let touch = touches.first else {return}
        
        moveFocus(to: touch.location(in: spawnerEntity().scene))
    }
    
    func touchesMoved(touches: Set<UITouch>) {
        
        //print("Component TM")
        
        guard let touch = touches.first else {return}
        
        moveFocus(to: touch.location(in: spawnerEntity().scene))
    }
    
    func touchesEnded(touches: Set<UITouch>) {
        //print("Component TE")
        
        endControl()
    }
    
    func touchesCancelled(touches: Set<UITouch>) {
        // print("Component CANCELLED")
        endControl()
    }
    
    
    private func endControl(){
        spawnerEntity().scene.controlDelegate = spawnerEntity().scene
        spawnerEntity().scene.switchPlayer()
    }
    
    private func moveFocus(to location:CGPoint){
        spawnerEntity().focus = location
        
        focusFire.position = location
        
    }
    
}
