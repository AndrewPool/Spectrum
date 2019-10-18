//
//  GameControlDelegate.swift
//  Spectrum
//
//  Created by Andrew Pool on 10/12/19.
//  Copyright © 2019 TokenResearch. All rights reserved.
//
import GameKit
import Foundation

extension SpectrumScene:ControlDelegate{
    
    // the game scene is the root delegate!
    //it passes off control to it's children, and when they're done they give it back. i think, hopefully
    
    
    // these are the default calls durring the game loop object is to select the next thing
    
    func touchesBegan(touches: Set<UITouch>) {
        
        print("spectrum scene self control delegate touchesBegan()")
        if let touch = touches.first{
            let location = touch.location(in: self)
            for spawner in game.spawnerEntities{
                if  let cc = spawner.controlComponent {
                    // ( spawner.playerComponent.player.physicsKey == currentPlayer.player.physicsKey) &&
                 
                    if (!cc.selected && spawner.target.contains(location)){
                        
                        cc.selected = true
                        game.selectedControlDelegates[touch] = cc
                        //controlDelegate = spawner.controlComponent
                        return//only do one per tap!
                    }
                }
                
            }
        }
    }
    
    func touchesMoved(touches: Set<UITouch>) {
        
    }
    //TODO
    func touchesEnded(touches: Set<UITouch>) {
      
    }
    func touchesCancelled(touches: Set<UITouch>) {
        
    }
    
    
//
//    func switchColors(){
//        for emitter in focusEmitterComposite.children{
//            if let emitterChange = emitter as? SKEmitterNode{
//
//            }
//        }
//    }
    
    //selected sets up the focus emmitter, or it doesn't
    
    func toggleSelected(isTrue:Bool){
        if(isTrue){
        print("gamescene true")
        addChild(focusEmitterComposite)
            updateFunc = updateGame(_:)
        
        } else {
            print("gamescene false")
            focusEmitterComposite.removeFromParent()
            updateFunc = {_ in}
            
        }
        
    }
    func setupFocusEmitterComposite(){
        let left = SKEmitterNode(fileNamed: Constants.GameSceen.Focus.leftSideFile)!
        
        left.particleColor = player.player.color
        left.particleColorSequence = nil
        left.position.x = -frame.maxX
        
        focusEmitterComposite.addChild(left)
        
        let right = SKEmitterNode(fileNamed: Constants.GameSceen.Focus.rightSideFile)!
        
        right.particleColor = player.player.color
        right.particleColorSequence = nil
        right.position.x = frame.maxX
        
        focusEmitterComposite.addChild(right)
        
        let top = SKEmitterNode(fileNamed: Constants.GameSceen.Focus.topSideFile)!
        
        top.particleColor = player.player.color
        top.particleColorSequence = nil
        top.position.y = frame.maxY
        
        focusEmitterComposite.addChild(top)

        let bottom = SKEmitterNode(fileNamed: Constants.GameSceen.Focus.bottomSideFile)!

        bottom.particleColor = player.player.color
        bottom.particleColorSequence = nil
        bottom.position.y = -frame.maxY

        focusEmitterComposite.addChild(bottom)


        
    }
    
}
