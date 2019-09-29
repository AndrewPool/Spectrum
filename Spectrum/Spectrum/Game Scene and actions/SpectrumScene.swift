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
    
    func changedState(for scene:SpectrumScene){
        switch (self){
        case .intro: scene.controlDelegate = StartUpDelegate(scene: scene)
            return
        case .playing: scene.controlDelegate = scene
        }
    }
    
}


class SpectrumScene: SKScene, SKPhysicsContactDelegate, ControlDelegate {
    
    
    var gameField = [SpawnerEntity]()
    
    private var state : State!{didSet{state.changedState(for: self)}}
    
    var player = Player()
    
    
    //always set this at the init! since this game doesn't delete things that can be delagates, I will not have to do any debugging aobut this latter
    // first real time doing an optional
    
    //this toggles the selected property of ControlDelegate thus letting it know to stop doing whatever it was doing as focused, and letting the new one to start
    var controlDelegate : ControlDelegate? {
        willSet{if controlDelegate != nil{controlDelegate?.selected = false}}
        didSet{controlDelegate!.selected = true}}
    
    //since this can be it's on delegate as it functions as the root controller, it has it's own delegate properties
    var selected = false {didSet{toggleSelected(isTrue:selected)}}
    
    
    private var lastUpdateTime : TimeInterval = 0
    private var label : SKLabelNode?
    private var focusEmitterComposite = SKNode()
    //private var spawner : Spawner!
    //private var selected : Selectable?
    
    
    //
    //----------------scene did load and game set up stuff below----------------
    
    override func sceneDidLoad() {
        
        self.lastUpdateTime = 0
        
        physicsWorld.contactDelegate = self
        physicsWorld.gravity = CGVector(dx: 0.0, dy: 0.0)
        
        setupFocusEmitterComposite()
        state = .intro
        addLabel()
        
    }
    
   
    
    private func addLabel(){
        self.label = self.childNode(withName: "//Title Label") as? SKLabelNode
        if let label = self.label {
            label.alpha = 0.0
            label.run(SKAction.fadeIn(withDuration: 2.0))
        }
    }
    
    
    //----------------scene did load aboce----------------
    
    
    
    
    
    
    //----------------set up game below----------------
       func setUpGame(){
           print("setting up game")
           label?.run(SKAction.fadeOut(withDuration: 5))
           controlDelegate = self
           addSpawner()
       }
       
       //gets called at set up game()\
       private func addSpawner(){
           let spawner = SpawnerEntity(scene: self, player: player)
           
           gameField.append(spawner)
           
       }
       
    
    //----------------  game set up stuff above----------------
    
    
   
    
    
    
    //-----------------touches and stuff below------------
    
    
    //these are called by the game engine, we might one day do event type checking here and what not, but right now it passes on the touch along with the scene to the delegate, and the delegate does what it wants, in the context
    // the first context is the StartUpDelegate one that's only implementation is that when touch begins, it calls gameScene.setUpGame()
    // we may or maynot require something something something
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        print("touchesBegan")
        
        if (controlDelegate != nil){
            controlDelegate!.touchesBegan(touches: touches)}
        
            if (isTrue){
                controlDelegate = gameField[0].controlComponent
                
            } else {
                controlDelegate = self
            }
             isTrue =   !isTrue
        
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
    var isTrue = true

    func touchesBegan(touches: Set<UITouch>) {
      
        print("spectrum scene self control delegate touchesBegan()")
       // guard let firstContact = touches.first else {return}
        guard let touch = touches.first else {return}
        
        
    
    }
    
    func touchesMoved(touches: Set<UITouch>) {
        
    }
    
    func touchesEnded(touches: Set<UITouch>) {
        
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
        
        for entity in gameField{
            entity.update(deltaTime: deltaTime)
        }
        // Calculate time since last update
       // let dt = currentTime - self.lastUpdateTime
       
       
        self.lastUpdateTime = currentTime
    }
    //-------------update above-------------------
    
    
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
        
        left.particleColor = player.color
        left.particleColorSequence = nil
        left.position.x = -CGFloat.screenX/2
        
        focusEmitterComposite.addChild(left)
        
        let right = SKEmitterNode(fileNamed: Constants.GameSceen.Focus.rightSideFile)!
        
        right.particleColor = player.color
        right.particleColorSequence = nil
        right.position.x = CGFloat.screenX/2
        
        focusEmitterComposite.addChild(right)
        
        let top = SKEmitterNode(fileNamed: Constants.GameSceen.Focus.topSideFile)!
        
        top.particleColor = player.color
        top.particleColorSequence = nil
        top.position.y = CGFloat.screenY/2
        
        focusEmitterComposite.addChild(top)

        let bottom = SKEmitterNode(fileNamed: Constants.GameSceen.Focus.bottomSideFile)!

        bottom.particleColor = player.color
        bottom.particleColorSequence = nil
        bottom.position.y = -CGFloat.screenY/2

        focusEmitterComposite.addChild(bottom)


        
    }
}



