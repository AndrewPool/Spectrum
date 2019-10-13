//
//  GameScene.swift
//  Spectrum
//
//  Created by Andrew Pool on 8/28/19.
//  Copyright © 2019 TokenResearch. All rights reserved.
//

import SpriteKit
import GameplayKit

enum State{
    
    case intro
    case playing
    //case paused
    //case over
    //i should use a state machine  for this, but i think it'll be fine.
    func changedState(for scene:SpectrumScene){
        switch (self){
        case .intro: scene.controlDelegate = StartUpDelegate(scene: scene)
            return
        case .playing: scene.controlDelegate = scene
            //case .paused : physicsDelegate.speed = 0.0
        }
    }
    
}


class SpectrumScene: SKScene, UISceneDelegate {
    
    
    var spawnerEntities = [SpawnerEntity]()
    var buddyEntities = [BuddyEntity]()
    
    let spawningSystem = GKComponentSystem(componentClass: SpawnerComponent.self)
    let gameSystem = GKComponentSystem(componentClass: GameComponent.self)
    
    private var state : State!{didSet{state.changedState(for: self)}}
    
    let neutralPlayer = PlayerComponent(player: Player())
    
    let player = PlayerComponent(player: Player(name: "andy", key: PhysicsKey.player1))
    //
    let player2 = PlayerComponent(player: Player(name: "jamie", key: PhysicsKey.player2, color:UIColor.yellow))
    //
    var currentPlayer : PlayerComponent!
    
    lazy var background: SKNode = {
        return SKNode()
    }()
    
    
    //this toggles the selected property of ControlDelegate thus letting it know to stop doing whatever it was doing as focused, and letting the new one to start
    var controlDelegate : ControlDelegate! {
        willSet{if controlDelegate != nil{controlDelegate?.selected = false}}
        didSet{controlDelegate!.selected = true}}
    
    //since this can be it's on delegate as it functions as the root game controller, it has it's own delegate properties
    var selected = false {didSet{toggleSelected(isTrue:selected)}}
    
    
    
    private var physicsDelegate : GamePhysicsDelegate!//i need a pointer to this
    
    private var pauseButton : SKSpriteNode?
  
    var focusEmitterComposite = SKNode()
    
    
    //game state
    
    private var lastUpdateTime : TimeInterval = 0
    
    private var spawnInterval = Constants.Spawner.pulseSpeedInterval
   
    private let buddypulseInterval = Constants.Spawner.pulseSpeedInterval/2
    
    private var buddypulseIntervalCount = Constants.Spawner.pulseSpeedInterval
    
  
    //
    //----------------scene did load and game set up stuff below----------------
    
    override func sceneDidLoad() {
        
        currentPlayer = player
        self.lastUpdateTime = 0
       
        physicsDelegate = GamePhysicsDelegate()
        physicsWorld.contactDelegate = physicsDelegate
        physicsWorld.gravity = CGVector(dx: 0.0, dy: 0.0)
         
        setupFocusEmitterComposite()
        state = .intro
        
        physicsBody = SKPhysicsBody(edgeLoopFrom: frame)
        physicsBody!.restitution = 1
        physicsBody!.friction = 0
        
        setupBackground()
       
    }
   
    //----------------scene did load aboce----------------
    

    
    
    
    
    //-------------------update below-----------------
    
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
        
        // Initialize _lastUpdateTime if it has not already been
        if (self.lastUpdateTime == 0) {
            self.lastUpdateTime = currentTime
        }
        
        let deltaTime = currentTime-lastUpdateTime
        
        
        
        buddypulseIntervalCount = buddypulseIntervalCount - deltaTime
        if buddypulseIntervalCount <= 0{
            buddypulseIntervalCount = buddypulseInterval
            for entity in buddyEntities{
                
                //i should note that deltatimeshouldn't be used here as  such.
                    entity.update(deltaTime: deltaTime)
                        }
        }
        
        
        
    
        // Calculate time since last update
        // let dt = currentTime - self.lastUpdateTime
        spawningSystem.update(deltaTime: deltaTime)
        gameSystem.update(deltaTime: deltaTime)
        
        //delete dead stuff
        for i in stride(from: buddyEntities.count-1, through: 0, by: -1){
            if(!buddyEntities.isEmpty){
                
                if buddyEntities[i].component(ofType: GameComponent.self)!.hp<=0{
                    if let buddyComponent =  buddyEntities[i].component(ofType: BuddyComponent.self){
                        buddyComponent.shapeNode.removeFromParent()
                    } 
                    
                    buddyEntities.remove(at: i)
                    
                }}
            
        }
        
        self.lastUpdateTime = currentTime
    }
    //-------------update above-------------------
    
    
   
    func pauseGame(){
        scene?.isPaused = true
        scene?.speed = 0.0
        print("pause")
     
    }
    func resume(){
        //self.lastUpdateTime = Date().timeIntervalSinceReferenceDate
        scene?.isPaused = false
        scene?.speed = 1.0
        print("resume")
    }
    
    
    
    func sceneWillResignActive(_ scene: UIScene) {
        physicsWorld.gravity = CGVector(dx: 100, dy: 100)
    }
    
    
    func switchPlayer(){
        if(currentPlayer.player.name==player.player.name){
            currentPlayer = player2
            
        } else{
            currentPlayer = player
        }
        switchColors()
    }
    
    
}



