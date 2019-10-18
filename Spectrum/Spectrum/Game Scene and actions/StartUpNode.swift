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
class StartUpNode:SceneControlNode{
    
    
      override var selected : Bool{didSet{toggleSelected(selected)}}
    lazy var label : SKLabelNode = {
        
        let l = SKLabelNode(text: "SET UP")
        l.position.y = 200
        l.configured()
        return l
    }()
  
    lazy var goArrow : SKSpriteNode = {
        let ga = SKSpriteNode(imageNamed: Constants.UI.GoArrowImageName)
        ga.scale(to: CGSize(width: 200.0 , height: 200*(ga.size.height/ga.size.width)))
        ga.position.y = -100
        ga.zPosition = CGFloat(Constants.Layers.topLayer)
       // ga.color = playerComponent.player.color
        ga.alpha = 0.5
        ga.run(SKAction.fadeRepeat())
       return ga
    }()

    //for carasalu
    
      let levels = Level.levels
    let spring:CGFloat = 300.0
    var index = 0
    var startMotion:CGFloat = 0.0
    
    private lazy var carousel : SKNode = getLevel()
    
    func getLevel()->SKNode{
    
        let c = SKNode()
        for p in levels[index]{
            let sh = SpectrumShape(shape: Shape.Circle, player: gameScene.player.player, size: Constants.Spawner.size)
            sh.position = p
           
            sh.startPulseAction()
           c.addChild(sh)
        }
        
        return c
    }
    
    override init(_ scene:SpectrumScene){
        super.init(scene)
        addChild(carousel)
                  
    }
//
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
                
    private func addLabel(){
       addChild(label)
       label.alpha = 0.0
               label.run(SKAction.fadeIn(withDuration: 5.0))
    }
    
    //toggle selected
    
    private func toggleSelected(_ selected:Bool){
        if(selected){
            gameScene.addChild(self)
            print("setup true")
            addLabel()
            addChild(goArrow)
          
        }else{
            print("setupfalse")
            label.run(SKAction.standardFadeOut())
            self.run(SKAction.standardFadeOut())
        }
    }
    
    
    //----------------set up game below----------------
    func setUpGame(){
        carousel.removeFromParent()
        print("setting up game")
        gameScene.game = Game()
        gameScene.addChild(gameScene.game.node)//this is terrible
        addSpawner(at: CGPoint(x: 150, y: 200),with:gameScene.player)
        addSpawner(at: CGPoint(x:-150, y: -200),with:gameScene.player)
       // addSpawner(at: CGPoint(x:150, y:-200),with:gameScene.player2)
        addSpawner(at: CGPoint(x:-150, y:200),with:gameScene.player2)
       // addNeutralSpawner(at: CGPoint(x:-300, y: 0))
       // addNeutralSpawner(at: CGPoint(x:300, y: 0))
        //addNeutralSpawner(at: CGPoint(x:0, y: -300))
        addNeutralSpawner(at: CGPoint(x:0, y: -200))
        gameScene.controlDelegate = gameScene
        gameScene.game.playing = true
        gameScene.setupPhysics()
        
    }
    
    private func addNeutralSpawner(at location:CGPoint){
        let spawner = SpawnerEntity(scene: gameScene, player:gameScene.neutralPlayer, location:location)
        gameScene.game.spawnerEntities.append(spawner)
        spawner.addGameComponent()
    }
    //gets called at set up game()\
    private func addSpawner(at location:CGPoint, with player:PlayerComponent){
        
        let spawner = SpawnerEntity(scene: gameScene, player:player, location: location)
        
        spawner.addGameComponent()
        spawner.addControlComponent()
        spawner.addSpawnerComponent()
        gameScene.game.spawnerEntities.append(spawner)
        
        
    }
    
    //----------------  game set up stuff above----------------
    
    
    
    
    
    
    
    //
    override func touchesBegan(touches: Set<UITouch>) {
        print("touchesBegan Delegate called")
        if let t = touches.first{
            if(goArrow.contains(t.location(in: gameScene))){
                setUpGame()
                
            }else{
                startMotion = t.location(in: gameScene).x
            }
            
        }
        
    }
    override func touchesMoved(touches: Set<UITouch>) {
        if  let t =  touches.first{
            let diff = (startMotion - t.location(in: gameScene).x )
            print(diff)
            print(startMotion)
            carousel.position.x =  diff
            if (diff>spring){
                
                index += 1
                if index > levels.count-1 {
                    index -= 1
                }
                else {
                    carousel.run(SKAction.move(to: CGPoint(x: 600.0, y: 0.0), duration: 2.0)){
                        self.removeFromParent()
                    }
                    
                    carousel = getLevel()
                    scene?.addChild(carousel)
                }
            }
            if (diff <= -spring){
                
                index -= 1
                if index < 0 {
                    index += 1
                }
                else {
                    carousel.run(SKAction.move(to: CGPoint(x: 600.0, y: 0.0), duration: 2.0)){
                        self.removeFromParent()
                    }
                    
                    carousel = getLevel()
                    scene?.addChild(carousel)
                }
            }
        }
        
    }
    
    override func touchesEnded(touches: Set<UITouch>) {
        //startMotion = 0.0
        carousel.run(SKAction.move(to:  CGPoint.zero, duration: 2.0))
        
    }
    
    override func touchesCancelled(touches: Set<UITouch>) {
       // startMotion = 0.0
         carousel.run(SKAction.move(to:  CGPoint.zero, duration: 2.0))
              
    }
    
    
    
}
