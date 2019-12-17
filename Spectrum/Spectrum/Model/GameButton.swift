//
//  GameButton.swift
//  Spectrum
//
//  Created by Andrew Pool on 11/22/19.
//  Copyright © 2019 TokenResearch. All rights reserved.
//

import GameKit

class GameButton: SKSpriteNode{
    
    
    //bang these, don't fuck this up!
    private var action: (()->Void)!
    
    static let BuildUp = Constants.Spawner.pulseSpeedInterval * 6
    public var countUp = 0.0
    
    var player: PlayerComponent!
    public var selectable = false;
    lazy var emmitter : SKEmitterNode = {
         let e = SKEmitterNode(fileNamed: "FocusFire.sks")!
            e.particleColor = player.player.color
        e.particleColorSequence = nil
            return e
        
    }()
    init(player: PlayerComponent, imageNamed: String, action: @escaping ()->Void) {
        self.player = player
        self.action = action
        let texture = SKTexture(imageNamed: imageNamed)
        
        super.init(texture: texture, color: UIColor.systemPink, size: CGSize(width: 80,height: 80))
        isUserInteractionEnabled = true
        //texture.applying(<#T##filter: CIFilter##CIFilter#>)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func toggleSelectable(_ yes:Bool){
        if(yes){
            selectable = yes
            addChild(emmitter)
        }else{
            selectable = yes
            emmitter.removeFromParent()
        }
        
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if countUp>GameButton.BuildUp{
            action!()
            countUp = 0
        }
    }
    
}

