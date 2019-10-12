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
        case .Circle: return CGPath(ellipseIn: CGRect(x: -size/2, y: -size/2, width: size, height: size), transform: nil)}
        
    }
    
}

//this is the shape with collision, player, color, animation setup and shit



class SpectrumShape : SKShapeNode {
//    override var description: String{
//        if(gameComponent == nil){
//            return "no game component \(size)"
//        }
//        return "has component"
//    }
    
    let shape : Shape
    
   // private var position = CGPoint(x: 100, y: 100)
    private var player:Player
    private var size:Int
    //shape color and stuff`
    let strokeWidth = 5
    let outlineColor = UIColor.red
    let inlineColor = UIColor.purple
    //cashe value
    var gameComponent : GameCollisionProtocol!

    //--------inits and set up funcs below------------------
    //todo this only does circles
    init(shape: Shape, player:Player, size:Int){
        
       
        self.shape = shape
        self.player = player
        self.size = size
        
        // let circlePath = CGPath(rect: , transform: nil)
        
        super.init()
        
        path = shape.getPath(size: size)
        zPosition = CGFloat(Constants.Layers.player)
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
    }
    func setUpCollisionAsSpawner(){
        physicsBody = SKPhysicsBody(circleOfRadius: CGFloat(size)/2)
        physicsBody!.isDynamic = false
        player.physicsKey.setupCollisionParamaters(spawner:physicsBody!)
       
              
        
    }
    func setUpCollisionAsBuddy(){
        physicsBody = SKPhysicsBody(circleOfRadius: CGFloat(size)/2)
         
        player.physicsKey.setupCollisionParamaters(buddy:physicsBody!)
        
        
    }
    
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //----------------init and set up funcs above

    
    func startPulseAction(){
        //first action
        let pulse2 = SKAction.scale(to: Constants.Spawner.pulseSizeScale, duration: Constants.Spawner.pulseSpeedInterval * 0.8)
        let pulse3 = SKAction.scale(to: CGFloat(1), duration: Constants.Spawner.pulseSpeedInterval * 0.2)
        let smallThenBigSequence = SKAction.sequence([pulse2,pulse3])
        let smallThenBigSequenceForever = SKAction.repeatForever(smallThenBigSequence)
        run(smallThenBigSequenceForever)//and back again forever
    }

  
}
