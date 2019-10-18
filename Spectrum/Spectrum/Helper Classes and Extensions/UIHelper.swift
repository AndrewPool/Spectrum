//
//  UIHelper.swift
//  Spectrum
//
//  Created by Andrew Pool on 10/15/19.
//  Copyright © 2019 TokenResearch. All rights reserved.
//

import Foundation
import GameKit

extension SKLabelNode{
     func configured(){
        self.fontSize = 100
        //self.position = CGPoint(x: 0, y: 0)
        self.zPosition = CGFloat(Constants.Layers.topLayer)
            
    }
}
