//
//  GameScene.swift
//  Spectrum
//
//  Created by Andrew Pool on 8/28/19.
//  Copyright © 2019 TokenResearch. All rights reserved.
//

import SpriteKit
import GameplayKit

class SpectrumScene: SKScene, UISceneDelegate {
    
    
   
    //var state : State!{didSet{state.changedState(for: self)}}
    
    let neutralPlayer = PlayerComponent(player: Player())
    
    let player = PlayerComponent(player: Player(name: "andy", key: PhysicsKey.player1))
    //
    let player2 = PlayerComponent(player: Player(name: "jamie", key: PhysicsKey.player2, color:UIColor.yellow))
    //
    
    //game control
    
    private var physicsDelegate : GamePhysicsDelegate!//i need a pointer to this
    
    
    
    //this toggles the selected property of ControlDelegate thus letting it know to stop doing whatever it was doing as focused, and letting the new one to start
    var controlDelegate : ControlDelegate! {
        willSet{if controlDelegate != nil{controlDelegate?.selected = false}}
        didSet{controlDelegate!.selected = true}}
    
    //since this can be it's on delegate as it functions as the root game controller, it has it's own delegate properties
    var selected = false {didSet{toggleSelected(isTrue:selected)}}
   
    //Visual Elements
    
    private var pauseButton : SKSpriteNode?//not state
    
    var focusEmitterComposite = SKNode()
    
    lazy var background: SKNode = { return SKNode()}()
    
    //game state
    
    var game  = Game()
    var updateFunc:(TimeInterval)->Void = {_ in }//this gets set twice, unfortunatly
    let voidUpdate:(TimeInterval)->Void = {_ in }
    //
    //----------------scene did load and game set up stuff below----------------
    
    override func sceneDidLoad() {
        
       
        game.lastUpdateTime = 0
        
        setupPhysics()
        
        setupFocusEmitterComposite()
        
        controlDelegate = SplashNode( self)
     
        setupBackground()
        
    }
    func setupPhysics(){
        physicsDelegate = GamePhysicsDelegate()
        physicsWorld.contactDelegate = physicsDelegate
        physicsWorld.gravity = CGVector(dx: 0.0, dy: 0.0)
        
    }
    
    //----------------scene did load aboce----------------
    

    
    
    
    
    //-------------------updatez below-----------------
    override func update(_ currentTime: TimeInterval) {
        updateFunc(currentTime)
    }
    
     func updateGame(_ currentTime: TimeInterval) {
      // winCheck()
        // Called before each frame is rendered
         //print("updating")
        // Initialize _lastUpdateTime if it has not already been
        if (game.lastUpdateTime == 0) {
            game.lastUpdateTime = currentTime
        }
        
        let deltaTime = currentTime-game.lastUpdateTime
        
        
        
        game.buddypulseIntervalCount = game.buddypulseIntervalCount - deltaTime
        if game.buddypulseIntervalCount <= 0{
            game.buddypulseIntervalCount = game.buddypulseInterval
            for entity in game.buddyEntities{
                //i should note that deltatime shouldn't be used here as  such.
                entity.update(deltaTime: deltaTime)
            }
        }
        
       
        game.spawningSystem.update(deltaTime: deltaTime)
        game.gameSystem.update(deltaTime: deltaTime)
        
  
        //delete dead stuff
        for i in stride(from: game.buddyEntities.count-1, through: 0, by: -1){
            if(!game.buddyEntities.isEmpty){
                
                if game.buddyEntities[i].component(ofType: GameComponent.self)!.hp<=0{
                    if let buddyComponent =  game.buddyEntities[i].component(ofType: BuddyComponent.self){
                        buddyComponent.shapeNode.removeFromParent()
                    } 
                    
                    game.buddyEntities.remove(at: i)
                    
                }}
            
        }
        
        game.lastUpdateTime = currentTime
      
    }
    override func didSimulatePhysics() {
        winCheck()
    }
    //win check
    private func winCheck() {
        //print(game.playing)
        if game.over && game.playing{
            //pauseGame()
         
                
         // pauseGame()
            game.newGame()
            controlDelegate = EndGameNode( self)
            physicsDelegate = GamePhysicsDelegate()
        
        }
        
        
    }
    //-------------update above-------------------
 
    
    
    
   //-------------game play functions
    func pauseGame(){
        game.playing = false
        scene?.isPaused = true
        scene?.speed = 0.0
        print("pause")
     
    }
    func resume(){
        //self.lastUpdateTime = Date().timeIntervalSinceReferenceDate
        scene?.isPaused = false
        scene?.speed = 1.0
        print("resume")
        game.playing = true
    }

    
    //this is a test
    func sceneWillResignActive(_ scene: UIScene) {
        physicsWorld.gravity = CGVector(dx: 100, dy: 100)
    }
    
   
//
    
}



