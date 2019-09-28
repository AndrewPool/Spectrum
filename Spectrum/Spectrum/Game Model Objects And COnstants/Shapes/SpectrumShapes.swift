//
//  SpectrumCircle.swift
//  Spectrum
//
//  Created by Andrew Pool on 9/14/19.
//  Copyright © 2019 TokenResearch. All rights reserved.
//

import GameKit

//this should be a protocol in the future enums are cute, but idk this isn't really a choice persay
//this enum configures the shape node
enum Shape{
    case Circle
    
    func getPath( size:Int)->CGPath{
        
        switch (self){
        case .Circle: return CGPath(ellipseIn: CGRect(x: -size/2, y: -size/2, width: size, height: size), transform: nil)}}}

//this is the shape with collision, player, color, animation setup and shit



class SpectrumShape : SKShapeNode {
    
    let shape : Shape
    
   // private var position = CGPoint(x: 100, y: 100)
    private var player:Player
    private var size:Int
    //shape color and stuff
    let strokeWidth = 5
    let outlineColor = UIColor.red
    let inlineColor = UIColor.purple
    //outline is the circle
   // let outline : SKShapeNode
    
   // let inline : SKShapeNode
    let pulseSpeedInterval = 1.0
    let pulseSizeScale = CGFloat(1.5)
    var controlDelegate : ControlDelegate?
    
    //--------inits and set up funcs below------------------
    //todo this only does circles
    init(shape: Shape, player:Player, size:Int){
        
        print(Constants.computerNames.first!)
        
        self.shape = shape
        self.player = player
        self.size = size
        
        // let circlePath = CGPath(rect: , transform: nil)
        
        super.init()
        
        path = shape.getPath(size: size)
      
        lineWidth = CGFloat(strokeWidth)
        fillColor = player.color
        strokeColor = inlineColor
        isUserInteractionEnabled = false// looks like this needs to be in the init
        physicsBody = SKPhysicsBody(circleOfRadius: CGFloat(size))
        player.physicsKey.setupCollisionParamaters(buddy:physicsBody!)
        
        
    }
    
    
 
    //this should be called imediatly after init()
    func addToScene(_ scene: SKScene){
        scene.addChild(self)
       
        startPulseAction()
       // scene.addChild(inline)
    }
    func setUpCollisionAsSpawner(){
        physicsBody = SKPhysicsBody(circleOfRadius: CGFloat(size))
          
        player.physicsKey.setupCollisionParamaters(spawner:physicsBody!)
        
        
    }
    func setUpCollisionAsBuddy(){
        physicsBody = SKPhysicsBody(circleOfRadius: CGFloat(size))
         
        player.physicsKey.setupCollisionParamaters(buddy:physicsBody!)
        
        
    }
    
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //----------------init and set up funcs above
   
    func setFocusVisuals(on:Bool){
       
    }
    
    
    
    //
    func startMoveToActions(){
        
    }
    
    
    func startPulseAction(){
        //first action
        let pulse2 = SKAction.scale(to: pulseSizeScale, duration: pulseSpeedInterval)
        let pulse3 = SKAction.scale(to: CGFloat(1), duration: pulseSpeedInterval)
        let smallThenBigSequence = SKAction.sequence([pulse2,pulse3])
        let smallThenBigSequenceForever = SKAction.repeatForever(smallThenBigSequence)
        run(smallThenBigSequenceForever)//and back again forever
    }

    func startMoveAction(to:CGPoint){
        removeAction(forKey: "move action")
        let speed = 1
        let moveAction = SKAction.move(by: CGVector(dx: to.x, dy: to.y), duration: TimeInterval(speed))
        run(moveAction,withKey: "move action")
    }
    
    //this is not used as a delegate, this is for when the main screen is selecting the context, so check the context
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    
    }
}
