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
    //cache
    weak var scene : SpectrumScene!
    
    
    var selected: Bool = false
    {didSet{if(selected)
    {self.target.addChild(focusFire)
        if let e : SpawnerEntity = entity as? SpawnerEntity {
            
            focusFire.particleColor = e.playerComponent.player.color}
    }
    else{focusFire.removeFromParent()}  }}
    
    
    //here are the various SKNodses
    private let getFocus : (()->CGPoint)!
    
    private lazy var focusFire : SKEmitterNode = {
        let focusFire = SKEmitterNode(fileNamed: "FocusFire.sks")!
        if let e : SpawnerEntity = entity as? SpawnerEntity {
            
            focusFire.particleColor = e.playerComponent.player.color
            focusFire.particleColorSequence = nil
            focusFire.zPosition = CGFloat(Constants.Layers.background)
            focusFire.name = "Focus Fire"
            
        }
        return focusFire
    }()
    //target is the root for the others
    lazy var target : SKSpriteNode = {
        let t = SKSpriteNode(imageNamed: Constants.UI.TargetImageName)
        
        if let e : SpawnerEntity = entity as? SpawnerEntity {
                   t.color = e.playerComponent.player.color
                  
               }
        
        
        t.zPosition = CGFloat(Constants.Layers.topLayer)
        
        t.alpha = 0.5
     
            t.position = getFocus()
        
        return t
        
    }()
    
    lazy var targetEmitter : SKEmitterNode = {
        let e = SKEmitterNode(fileNamed: "TargetEmitter")!
        if let se : SpawnerEntity = entity as? SpawnerEntity {
            e.particleColor = se.playerComponent.player.color
            e.particleColorSequence = nil
        }
        e.particleColorSequence = nil
        e.speed = 0.3
        e.alpha = 1
        e.zPosition = 10
        
        return e
    }()
    /// end SKNODES above
    
    
    ///init
    
    init(scene: SpectrumScene, getFocus:@escaping ()->CGPoint) {
        self.scene = scene
        self.getFocus = getFocus
        super.init()
        scene.game.node.addChild(target)
        target.addChild(targetEmitter)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //init above
    
  
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
    //this is the meatty funciton
    private func moveFocus(to location:CGPoint){
      
      //  focus = location
        let e = entity! as! SpawnerEntity
        e.focus = location
        target.position = location
     
       //getts the bubbles flowing in the right direction
        if let e = entity as? SpawnerEntity{
            
            targetEmitter.xAcceleration = ( e.location.x - target.position.x)*1.5
            targetEmitter.yAcceleration = (e.location.y - target.position.y)*1.5
        }
        
}

    override func willRemoveFromEntity() {
          //let e = entity! as! SpawnerEntity
       // e.focus = e.location
        target.run(SKAction.sequence([SKAction.fadeOut(withDuration: Constants.GameSceen.FadeOutDuration/2),SKAction.removeFromParent()]))
        print("will remove control component")
    }


}

