//
//  SKActions.swift
//  Spectrum
//
//  Created by Andrew Pool on 10/15/19.
//  Copyright © 2019 TokenResearch. All rights reserved.
//

import Foundation
import GameKit
extension SKAction{
    static func standardFadeOut()->SKAction{
        
        return SKAction.sequence([SKAction.fadeOut(withDuration: Constants.GameSceen.FadeOutDuration),SKAction.removeFromParent()])
    }
    
    static func fadeRepeat()->SKAction{
        let a = SKAction.fadeOut(withDuration: Constants.GameSceen.FadeOutDuration*2)
        let b = SKAction.fadeIn(withDuration: Constants.GameSceen.FadeOutDuration*2)
        return SKAction.repeatForever(SKAction.sequence([a,b]))
    }
}

