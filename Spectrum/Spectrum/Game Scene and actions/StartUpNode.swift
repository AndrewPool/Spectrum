//
//  StartGameDelegate.swift
//  Spectrum
//
//  Created by Andrew Pool on 9/23/19.
//  Copyright © 2019 TokenResearch. All rights reserved.
//

import Foundation
import GameKit

enum setUpState{
    case idle
    case swiping
    case animating
    case mightPlay
}


class StartUpNode:SceneControlNode{
    
    private var state: setUpState = .idle
    override var selected : Bool{didSet{toggleSelected(selected)}}
    
    lazy var label : SKLabelNode = {
        let l = SKLabelNode(text: "<-SWIPE->")
        l.position.y = scene!.frame.maxY - 100
        l.configured()
        l.alpha = 0.0
        l.run(SKAction.fadeIn(withDuration: 5.0))
        return l
    }()
    
    lazy var goArrow : SKSpriteNode = {
        let ga = SKSpriteNode(imageNamed: Constants.UI.GoArrowImageName)
        ga.scale(to: CGSize(width: 200.0 , height: 200*(ga.size.height/ga.size.width)))
        ga.position.y = -300
        ga.zPosition = CGFloat(Constants.Layers.topLayer)
        // ga.color = playerComponent.player.color
        ga.alpha = 0.5
        ga.run(SKAction.fadeRepeat())
        return ga
    }()
    
    //for carasalu
    var touch : UITouch?
    let levels = Level.locations
    let spring:CGFloat = 300.0
    var index = Level.locations.count - 1
    var startMotion:CGFloat = 0.0
    
    private lazy var playerOptions = [ 0:gameScene.neutralPlayer,1:gameScene.player,2:gameScene.player2]
    
    
    private lazy var carousel : SKNode = getLevel()
    
    func getLevel()->SKNode{
        let players = Level.flavors[index]
        let c = SKNode()
        for (i,p) in levels[index].enumerated(){
           
            let sh = SpectrumShape(shape: Shape.Circle, player: playerOptions[players[i]]!.player, size: Constants.Spawner.size)
            sh.position = p
           
            sh.startPulseAction()
           c.addChild(sh)
        }
        c.alpha = 0.0
        c.run(SKAction.fadeIn(withDuration: 2.0))
        return c
    }
    
  
    
    //toggle selected
    
    private func toggleSelected(_ selected:Bool){
        if(selected){
            gameScene.addChild(self)
            print("setup true")
            addChild(carousel)
            addChild(label)
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
         gameScene.addChild(gameScene.game.node)
        addSpawners(locations:levels[index], flavors:Level.flavors[index])
        
        
    }
    func addSpawners(locations:[CGPoint], flavors:[Int]){
        for (i,location) in locations.enumerated(){
            if flavors[i] == 0{//check for neutral spawner
                addNeutralSpawner(at: location)
            } else{
                addSpawner(at: location, with: playerOptions[flavors[i]]!)
            }
        }
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
    
    
    
    
    
    
    
    //--------touches below-----------------
    override func touchesBegan(touches: Set<UITouch>) {
        print("touchesBegan Delegate called")
        
        switch state{
        case .idle:if let t = touches.first{
            if(goArrow.contains(t.location(in: gameScene))){
                state = .mightPlay
                touch = t
            }else{
                startMotion = t.location(in: gameScene).x
                state = .swiping
                touch = t
            }
            
            }
            
        default:
            break
        }
        
    }
    override func touchesMoved(touches: Set<UITouch>) {
        
        switch state{
        case .swiping:
            
            
                let diff = (startMotion - touch!.location(in: gameScene).x )
                print(diff)
                print(startMotion)
                carousel.position.x =  -diff
                if (diff>spring){
                    index -= 1
                    if index < 0 {
                        index += 1
                    }
                        
                    else {
                        state = .animating
                        carousel.run(SKAction.move(to: CGPoint(x: -600.0, y: 0.0), duration: 0.8)){
                            self.state = .idle
                            self.carousel.removeFromParent()
                            self.carousel = self.getLevel()
                            self.scene?.addChild(self.carousel)
                            
                        }
                        
                        
                    }
                }
                if (diff <= -spring){
                    index += 1
                    if index > levels.count-1 {
                        index -= 1
                    }
                        
                    else {
                        state = .animating
                        carousel.run(SKAction.move(to: CGPoint(x: 600.0, y: 0.0), duration: 0.8)){
                            self.state = .idle
                            self.carousel.removeFromParent()
                            self.carousel = self.getLevel()
                            self.scene?.addChild(self.carousel)
                            
                        }
                        
                    }
                }
        default:
            break
        }
        
    }
    
    override func touchesEnded(touches: Set<UITouch>) {
        //startMotion = 0.0
        switch state {
        case .mightPlay:
            if(goArrow.contains(touch!.location(in: gameScene))){
                          setUpGame()
            }
            state = .idle
        case .swiping:
            state = .animating
            carousel.run(SKAction.move(to:  CGPoint.zero, duration: 0.8)){
                self.state = .idle
            }
        default: state = .idle
            
        }
        touch = nil
        
        
    }
    
    override func touchesCancelled(touches: Set<UITouch>) {
        switch state {
            
        case .swiping:
            state = .animating
            carousel.run(SKAction.move(to:  CGPoint.zero, duration: 0.8)){
                self.state = .idle
            }
            
        default:
            state = .idle
        }
        
        touch = nil
        
    }
    
    
    //------touches above------------------
      
        //------init---------------
        override init(_ scene:SpectrumScene){
            super.init(scene)
           
        }
    //
        required init?(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        //----------init above
        
    
    
}
