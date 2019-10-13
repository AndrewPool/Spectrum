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
class StartUpDelegate:SKNode, ControlDelegate{
   
    
    var selected = false{didSet{toggleSelected(selected)}}
    private var label : SKLabelNode?
    weak var gameScene : SpectrumScene!
    
    //
    init(scene:SpectrumScene){
        self.gameScene = scene
        super.init()
        addLabel()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func addLabel(){
        
        self.label = gameScene.childNode(withName: "//Title Label") as? SKLabelNode
        if let label = self.label {
            label.alpha = 0.0
            label.run(SKAction.fadeIn(withDuration: 5.0))
        }
    }
    
    //toggle selected
    
    private func toggleSelected(_ selected:Bool){
        if(selected){
            
        }else{
            label?.run(SKAction.fadeOut(withDuration: 2.0)){
                self.label?.removeFromParent()
            }
            self.run(SKAction.fadeOut(withDuration: 2.0)){
                self.removeFromParent()
            }
        }
    }
    
    
    
    //----------------set up game below----------------
    func setUpGame(){
        print("setting up game")
        
        
        addSpawner(at: CGPoint(x: 150, y: 200))
       addSpawner(at: CGPoint(x:-150, y: -200))
        addSpawner2(at: CGPoint(x:150, y:-200))
        addSpawner2(at: CGPoint(x:-150, y:200))
        addNeutralSpawner(at: CGPoint(x:-300, y: 0))
        addNeutralSpawner(at: CGPoint(x:300, y: 0))
        addNeutralSpawner(at: CGPoint(x:0, y: -300))
        addNeutralSpawner(at: CGPoint(x:0, y: 300))
        gameScene.controlDelegate = gameScene
    }
    
    private func addNeutralSpawner(at location:CGPoint){
        let spawner = SpawnerEntity(scene: gameScene, player:gameScene.neutralPlayer, location:location)
        gameScene.spawnerEntities.append(spawner)
    }
    //gets called at set up game()\
    private func addSpawner(at location:CGPoint){
        
        let spawner = SpawnerEntity(scene: gameScene, player:gameScene.player, location: location)
        
        gameScene.spawnerEntities.append(spawner)
        
        
    }
    private func addSpawner2(at location:CGPoint){
        
        let spawner = SpawnerEntity(scene: gameScene,  player:gameScene.player2, location: location)
        
        gameScene.spawnerEntities.append(spawner)
        
    }
    
    //----------------  game set up stuff above----------------
    
    
    
    
    
    
    
    //
    func touchesBegan(touches: Set<UITouch>) {
        print("touchesBegan Delegate called")
        setUpGame()
        
    }
    
    func touchesMoved(touches: Set<UITouch>) {
        
    }
    
    func touchesEnded(touches: Set<UITouch>) {
        
    }
    
    func touchesCancelled(touches: Set<UITouch>) {
        
    }
    
    
    
}
