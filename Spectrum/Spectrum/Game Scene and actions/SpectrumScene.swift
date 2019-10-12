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


class SpectrumScene: SKScene, UISceneDelegate, ControlDelegate {
    
    
    var spawnerEntities = [SpawnerEntity]()
    var buddyEntities = [BuddyEntity]()
    
    let spawningSystem = GKComponentSystem(componentClass: SpawnerComponent.self)
    let gameSystem = GKComponentSystem(componentClass: GameComponent.self)
    
    private var state : State!{didSet{state.changedState(for: self)}}
    
    
    let player = PlayerComponent(player: Player(name: "andy", key: PhysicsKey.player1))
    //
    let player2 = PlayerComponent(player: Player(name: "jamie", key: PhysicsKey.player2, color:UIColor.yellow))
    //
    var currentPlayer : PlayerComponent!
    
    
    //this toggles the selected property of ControlDelegate thus letting it know to stop doing whatever it was doing as focused, and letting the new one to start
    var controlDelegate : ControlDelegate! {
        willSet{if controlDelegate != nil{controlDelegate?.selected = false}}
        didSet{controlDelegate!.selected = true}}
    
    //since this can be it's on delegate as it functions as the root game controller, it has it's own delegate properties
    var selected = false {didSet{toggleSelected(isTrue:selected)}}
    
    
    private var lastUpdateTime : TimeInterval = 0
    
    
    private var physicsDelegate : GamePhysicsDelegate!//i need a pointer to this
    private var pauseButton : SKSpriteNode?
  
    private var focusEmitterComposite = SKNode()
    
    //game state
    
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
        
    
       
    }
    
    //----------------scene did load aboce----------------
    
    
    
  
    
    
    
    //-----------------touches and stuff below------------
    
    
    //these are called by the game engine, we might one day do event type checking here and what not, but right now it passes on the touch along with the scene to the delegate, and the delegate does what it wants, in the context
    // the first context is the StartUpDelegate one that's only implementation is that when touch begins, it calls gameScene.setUpGame()
    // we may or maynot require something something something
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        print("touchesBegan")
        
        if (controlDelegate != nil){
            controlDelegate!.touchesBegan(touches: touches)
            
        }
        
        
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if (controlDelegate != nil){controlDelegate!.touchesMoved(touches: touches)}
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if (controlDelegate != nil){controlDelegate!.touchesEnded(touches: touches)}
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        if (controlDelegate != nil){controlDelegate!.touchesCancelled(touches: touches)}
    }
    
    
    // the game scene is the root delegate!
    //it passes off control to it's children, and when they're done they give it back. i think, hopefully
    
    
    // these are the default calls durring the game loop object is to select the next thing
    
    func touchesBegan(touches: Set<UITouch>) {
        
        print("spectrum scene self control delegate touchesBegan()")
        
    }
    
    func touchesMoved(touches: Set<UITouch>) {
        
    }
    //TODO
    func touchesEnded(touches: Set<UITouch>) {
        if let touch = touches.first{
            let location = touch.location(in: self)
            for spawner in spawnerEntities{
                if (spawner.playerComponent.player.physicsKey == currentPlayer.player.physicsKey){
                    if (spawner.shapeComponent.shapeNode.contains(location)){
                        
                        controlDelegate = spawner.controlComponent
                        
                    }
                }
                
            }
        }
    }
    func touchesCancelled(touches: Set<UITouch>) {
        
    }
    
    //-----------------touches and helpers and ControlDelegate above--------------
    
    
    
    
    
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
    
    
    //-------------Contact Delegate--------------//
   
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
    
    
    
    //selected sets up the focus emmitter, or it doesn't
    
    private func toggleSelected(isTrue:Bool){
        if(isTrue){
        
        addChild(focusEmitterComposite)
        
        } else {
            focusEmitterComposite.removeFromParent()
        }
        
    }
    private func setupFocusEmitterComposite(){
        let left = SKEmitterNode(fileNamed: Constants.GameSceen.Focus.leftSideFile)!
        
        left.particleColor = currentPlayer.player.color
        left.particleColorSequence = nil
        left.position.x = -frame.maxX
        
        focusEmitterComposite.addChild(left)
        
        let right = SKEmitterNode(fileNamed: Constants.GameSceen.Focus.rightSideFile)!
        
        right.particleColor = currentPlayer.player.color
        right.particleColorSequence = nil
        right.position.x = frame.maxX
        
        focusEmitterComposite.addChild(right)
        
        let top = SKEmitterNode(fileNamed: Constants.GameSceen.Focus.topSideFile)!
        
        top.particleColor = currentPlayer.player.color
        top.particleColorSequence = nil
        top.position.y = frame.maxY
        
        focusEmitterComposite.addChild(top)

        let bottom = SKEmitterNode(fileNamed: Constants.GameSceen.Focus.bottomSideFile)!

        bottom.particleColor = currentPlayer.player.color
        bottom.particleColorSequence = nil
        bottom.position.y = -frame.maxY

        focusEmitterComposite.addChild(bottom)


        
    }
    func switchColors(){
        for emitter in focusEmitterComposite.children{
            if let emitterChange = emitter as? SKEmitterNode{
                emitterChange.particleColor = currentPlayer.player.color
            }
        }
    }
    
    func switchPlayer(){
        if(currentPlayer.player.name==player.player.name){
            currentPlayer = player2
            
        } else{
            currentPlayer = player
        }
        switchColors()
    }
    
    func sceneWillResignActive(_ scene: UIScene) {
        physicsWorld.gravity = CGVector(dx: 100, dy: 100)
    }
}



