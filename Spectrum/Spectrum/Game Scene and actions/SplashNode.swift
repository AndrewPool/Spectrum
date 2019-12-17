//
//  SplashDelegate.swift
//  Spectrum
//
//  Created by Andrew Pool on 10/17/19.
//  Copyright © 2019 TokenResearch. All rights reserved.
//

import GameKit
//this is the delegate for the start of the game, basilcly,it's a bunch of code, so that we don't have to constantly bechecking the game state
class SplashNode:SceneControlNode{
    
    
    override var selected : Bool {didSet{toggleSelected(selected)}}
    lazy var label : SKLabelNode = {
        
        let l = SKLabelNode(text: "SPECTRUM")
        l.configured()
        return l
    }()
    lazy var tap : SKLabelNode = {
           
           let t = SKLabelNode(text: "tap")
      
           t.configured()
        t.alpha = 0.0
          t.position.y = -300
        t.run(SKAction.fadeRepeat())
           return t
       }()
    override init(_ scene:SpectrumScene){
        super.init(scene)
    }
    
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
            addChild(tap)
            
        }else{
            print("setupfalse")
            tap.run(SKAction.standardFadeOut())
            label.run(SKAction.standardFadeOut())
            self.run(SKAction.standardFadeOut())
        }
    }
    
    
    
   
    //----------------  game set up stuff above----------------
    
    
    
    
    
    
    
    //
    override func touchesBegan(touches: Set<UITouch>) {
        print("Splash NOde touch called")
              gameScene.controlDelegate = StartUpNode(gameScene)
        
    }
    
    
    
}
