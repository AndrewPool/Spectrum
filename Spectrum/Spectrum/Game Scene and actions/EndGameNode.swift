//
//  EndGameNode.swift
//  Spectrum
//
//  Created by Andrew Pool on 10/15/19.
//  Copyright © 2019 TokenResearch. All rights reserved.
//

//import Foundation
import GameKit
class EndGameNode:SceneControlNode{
    
    
    override var selected : Bool{didSet{toggleSelected(selected)}}
    private lazy var label : SKNode = {
       
      
        return SKLabelNode()
    }()
   
    
    private func addLabel(){
        //label.s= gameScene.frame
        let winner = SKLabelNode(text: "WINNER")
        winner.configured()
        winner.position.y = winner.position.y + 100
        addChild(winner)
        let isText = SKLabelNode(text: "is")
        isText.configured()
        addChild(isText)
        let you = SKLabelNode(text: "YOU!")
        you.configured()
        you.position.y = you.position.y - 100
        addChild(you)
        
        
      
    }
    override init(_ scene: SpectrumScene) {
        super.init(scene)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //toggle selected
    
    private func toggleSelected(_ selected:Bool){
        if(selected){
            print("endgame true")
            gameScene.addChild(self)
            addLabel()
            alpha = 0.0
            run(SKAction.fadeIn(withDuration: 5.0))
            
        }else{
             self.run(SKAction.standardFadeOut())
        }
    }
    
    
    
 
 
    
    //----------------  game set up stuff above----------------
    
    
    
    
    
    
    
    //
    override func touchesBegan(touches: Set<UITouch>) {
        print("EndGame Delegate touches began")
        gameScene.controlDelegate = SplashNode( gameScene)
        
    }
    
    
    
}
