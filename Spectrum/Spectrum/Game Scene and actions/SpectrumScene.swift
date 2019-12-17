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
    lazy var playersButtons : [PlayerComponent:GameButton] = [player:p1groupControl, player2:p2groupControl]
    //game control
    private var physicsDelegate : GamePhysicsDelegate!//i need a pointer to this
    
    //this is some word salad, it is everything that happens when you press the bonus button. it's a fucking work salad. idk not much to do other than explain each line,\TODO
    //also this should probably be somewhere else... I need to make these entities...
    private func setControlForPlayer(player:PlayerComponent){
        let otherPlayersEntitiesWithControlComponents = game.spawnerEntities.filter(){$0.playerComponent != player && !$0.playerComponent.player.computer}
        for e in otherPlayersEntitiesWithControlComponents{
            e.removeComponent(ofType: ControlComponent.self)
        }
        controlDelegate = BonusControlDelegate(selected: true, player: player, scene: self)
        playersButtons[player]?.toggleSelectable(false)
        p1groupControl.removeFromParent()
        p2groupControl.removeFromParent()
        setupFocusEmitterComposite(player: player)
        addChild(focusEmitterComposite)
        
        focusEmitterComposite.run(SKAction.fadeOut(withDuration: Constants.Spawner.pulseSpeedInterval*2)){
            self.focusEmitterComposite.removeFromParent()
            
            self.controlDelegate = self
            self.addChild(self.p1groupControl)
            self.addChild(self.p2groupControl)
            for e in otherPlayersEntitiesWithControlComponents{
                e.addControlComponent()
            }
        }
        
        
        
    }
    //for making the game playable.
   lazy private var p1groupControl : GameButton = {
        
    let gb = GameButton(player:player, imageNamed: "BlueStar", action:{
            print("BlueStar squence start")
           
            self.setControlForPlayer(player:self.player)
            
            
            print("BlueStar sequence complete")
        })
      
        gb.position = CGPoint(x: 400, y: 50)
        gb.zPosition = 10
        
        
        
        return gb
    }()
    lazy private var p2groupControl : GameButton = {
        let gb = GameButton(player:player2, imageNamed: "YellowStar", action:{
            self.setControlForPlayer(player:self.player2)
            print("YellowStar")
        })
        
        gb.position = CGPoint(x: -400, y: 50)
        gb.zPosition = 10
        
        
        
        return gb
    }()
    
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
        
        controlDelegate = SplashNode(self)
     
        setupBackground()
        
    }
    func setupPhysics(){
        physicsDelegate = GamePhysicsDelegate()
        physicsWorld.contactDelegate = physicsDelegate
        physicsWorld.gravity = CGVector(dx: 0.0, dy: 0.0)
        
    }
    func setupUI(){
        game.node.addChild(p1groupControl)
        game.node.addChild(p2groupControl)
    }
    
    //----------------scene did load aboce----------------
    

    
    
    
    
    //-------------------updatez below-----------------
    override func update(_ currentTime: TimeInterval) {
        updateFunc(currentTime)
    }
    
     func updateGame(_ currentTime: TimeInterval) {
      
        // Called before each frame is rendered
         //print("updating")
        // Initialize _lastUpdateTime if it has not already been
        if (game.lastUpdateTime == 0) {
            game.lastUpdateTime = currentTime
        }
        
        let deltaTime = currentTime-game.lastUpdateTime
        
        for b in playersButtons.values{
            b.countUp += deltaTime
            if b.countUp > GameButton.BuildUp && b.selectable == false {
                b.toggleSelectable(true)
            }
        }
        
        game.buddypulseIntervalCount = game.buddypulseIntervalCount - deltaTime
        if game.buddypulseIntervalCount <= 0{
            game.buddypulseIntervalCount = Constants.Spawner.pulseSpeedInterval
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
            updateFunc = {_ in}
            game.newGame()
            controlDelegate = EndGameNode(self)
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

    
    //this is a test i don't think this ever fires
    func sceneWillResignActive(_ scene: UIScene) {
        physicsWorld.gravity = CGVector(dx: 100, dy: 100)
    }
    
   
//
    
}



