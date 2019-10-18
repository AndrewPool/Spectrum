//
//  ControlComponent.swift
//  Spectrum
//
//  Created by Andrew Pool on 9/28/19.
//  Copyright © 2019 TokenResearch. All rights reserved.
//
import UIKit
import GameKit

//this currently can only be owned by the spawner entity
class ControlComponent: GKComponent,ControlDelegate{
    
    var selected: Bool = false
    {didSet{if(selected){
        if let e : SpawnerEntity = entity as? SpawnerEntity {e.scene.addChild(focusFire) }} else{focusFire.removeFromParent()}  }}
    
    
    //here are the various SKNodes
    lazy var focusFire : SKEmitterNode = {
        let focusFire = SKEmitterNode(fileNamed: "FocusFire.sks")!
        if let e : SpawnerEntity = entity as? SpawnerEntity {
            
            focusFire.position = e.focus
            focusFire.particleColor = e.playerComponent.player.color
            focusFire.particleColorSequence = nil
            focusFire.zPosition = CGFloat(Constants.Layers.background)
            focusFire.name = "Focus Fire"
            
        }
        return focusFire
    }()
     init(scene: SpectrumScene) {
        self.scene = scene
        super.init()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //cache
    weak var scene : SpectrumScene!
    
    //---------delegate controls below
    func touchesBegan(touches: Set<UITouch>) {
        //print("Component TD")
        guard let touch = touches.first else {return}
        focusFire.zPosition = CGFloat(Constants.Layers.topLayer)
        moveFocus(to: touch.location(in: scene!))
    }
    
    func touchesMoved(touches: Set<UITouch>) {
        
        //print("Component TM")
        
        guard let touch = touches.first else {return}
        
        moveFocus(to: touch.location(in: scene!))
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
        selected = false
      //  scene.controlDelegate = spawnerEntity().scene
       focusFire.zPosition = CGFloat(Constants.Layers.background)
    }
    
    private func moveFocus(to location:CGPoint){
       if let e : SpawnerEntity = entity as? SpawnerEntity {
        e.focus = location
        
        focusFire.position = location
        
        }}
    
}
